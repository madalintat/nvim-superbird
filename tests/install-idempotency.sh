#!/usr/bin/env bash
# Smoke: document-viewer system deps are present on PATH.
# These are installed by install.sh's install_doc_deps function.
set -e

MISSING=0
for cmd in convert gs soffice pandoc xlsx2csv; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "MISS: $cmd"
    MISSING=$((MISSING+1))
  fi
done

if [ "$MISSING" -gt 0 ]; then
  echo "FAIL: $MISSING dep(s) missing — run install.sh"
  exit 1
fi

echo "PASS"
