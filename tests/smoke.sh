#!/usr/bin/env bash
# Verify that opening each fixture file with headless nvim resolves to the
# expected outcome after our converters / plugins have run.
#
# Two probe types:
#  - probe_ft  : asserts vim.bo.filetype (text-routed formats)
#  - probe_ok  : asserts the buffer loaded (image-routed formats handled by
#                snacks, which intentionally leaves ft unset)
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIX="$HERE/fixtures"
PASS=0; FAIL=0

[ -f "$FIX/sample.csv" ] || { echo "Run tests/fixtures/generate.sh first."; exit 2; }

# Extract a single sentinel value from nvim's stdout, ignoring noise.
nvim_eval() {
  local file="$1" expr="$2" raw
  raw="$(nvim --headless \
              -c "edit $file" \
              -c "lua io.stdout:write('<<R:'..($expr)..':END>>')" \
              -c "qa!" 2>/dev/null)"
  printf '%s' "$raw" | grep -oE '<<R:[^:]*:END>>' | head -1 | sed 's/<<R://; s/:END>>//'
}

probe_ft() {
  local file="$1" expected="$2"
  local got; got="$(nvim_eval "$file" "vim.bo.filetype")"
  if [ "$got" = "$expected" ]; then
    printf 'PASS %-22s ft=%s\n' "$(basename "$file")" "$got"; PASS=$((PASS+1))
  else
    printf 'FAIL %-22s ft=%s (expected %s)\n' "$(basename "$file")" "${got:-<empty>}" "$expected"; FAIL=$((FAIL+1))
  fi
}

probe_ok() {
  # Verify the buffer loaded *something* — for image-like formats whose
  # contents are rendered out-of-band by snacks. The buffer either has lines
  # or its name has been rewritten to a cache file.
  local file="$1"
  local got; got="$(nvim_eval "$file" "(vim.api.nvim_buf_line_count(0) > 0 and 'lines' or 'empty')")"
  if [ "$got" = "lines" ]; then
    printf 'PASS %-22s loaded\n' "$(basename "$file")"; PASS=$((PASS+1))
  else
    printf 'FAIL %-22s did not load\n' "$(basename "$file")"; FAIL=$((FAIL+1))
  fi
}

probe_renamed_to_pdf() {
  # pptx specifically: our BufReadCmd renames the buffer to .../docview/*.pdf.
  local file="$1"
  local got; got="$(nvim_eval "$file" "(vim.fn.expand('%'):match('%.pdf$') and 'pdf' or 'other')")"
  if [ "$got" = "pdf" ]; then
    printf 'PASS %-22s renamed to .pdf\n' "$(basename "$file")"; PASS=$((PASS+1))
  else
    printf 'FAIL %-22s buffer not renamed\n' "$(basename "$file")"; FAIL=$((FAIL+1))
  fi
}

probe_ok                "$FIX/sample.png"
probe_ft                "$FIX/sample.svg"   svg
probe_ok                "$FIX/sample.pdf"
probe_ft                "$FIX/sample.csv"   csv
probe_ft                "$FIX/sample.docx"  markdown
probe_ft                "$FIX/sample.xlsx"  csv
probe_renamed_to_pdf    "$FIX/sample.pptx"
probe_ft                "$FIX/sample.ipynb" markdown

echo "---"
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
