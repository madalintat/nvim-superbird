#!/usr/bin/env bash
# Verify that opening each fixture file with headless nvim resolves to the
# expected filetype after our converters / plugins have run.
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIX="$HERE/fixtures"
PASS=0; FAIL=0

[ -f "$FIX/sample.csv" ] || { echo "Run tests/fixtures/generate.sh first."; exit 2; }

probe_ft() {
  # $1 = file, $2 = expected ft
  local file="$1" expected="$2" raw got
  raw="$(nvim --headless \
              -c "edit $file" \
              -c "lua io.stdout:write('<<FT:'..vim.bo.filetype..':END>>')" \
              -c "qa!" 2>/dev/null)"
  got="$(printf '%s' "$raw" | grep -oE '<<FT:[^:]*:END>>' | head -1 | sed 's/<<FT://; s/:END>>//')"
  if [ "$got" = "$expected" ]; then
    printf 'PASS %-22s -> %s\n' "$(basename "$file")" "$got"; PASS=$((PASS+1))
  else
    printf 'FAIL %-22s -> %s (expected %s)\n' "$(basename "$file")" "${got:-<empty>}" "$expected"; FAIL=$((FAIL+1))
  fi
}

probe_ft "$FIX/sample.png"   png
probe_ft "$FIX/sample.svg"   svg
probe_ft "$FIX/sample.pdf"   pdf
probe_ft "$FIX/sample.csv"   csv
probe_ft "$FIX/sample.docx"  markdown
probe_ft "$FIX/sample.xlsx"  csv
probe_ft "$FIX/sample.pptx"  pdf
probe_ft "$FIX/sample.ipynb" markdown

echo "---"
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
