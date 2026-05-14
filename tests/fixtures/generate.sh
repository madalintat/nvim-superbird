#!/usr/bin/env bash
# Generate small real fixtures for each supported format.
# Requires deps from install.sh.
set -e
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE"

echo "Generating fixtures in $HERE..."

# CSV — trivial.
cat > sample.csv <<'EOF'
name,age,city
Ada,36,London
Linus,55,Portland
Grace,85,New York
EOF

# Markdown source used to build pdf/docx/pptx.
cat > _source.md <<'EOF'
# Sample Document

This is a fixture for nvim-superbird document viewers.

## Features

- View images
- View PDFs
- View spreadsheets
EOF

# PDF via pandoc; falls back to libreoffice.
if pandoc _source.md -o sample.pdf 2>/dev/null; then
  :
else
  soffice --headless --convert-to pdf _source.md >/dev/null
  mv _source.pdf sample.pdf
fi

# DOCX via pandoc.
pandoc _source.md -o sample.docx

# PPTX via pandoc.
pandoc _source.md -o sample.pptx

# XLSX from the csv via python+openpyxl.
python3 -c "import openpyxl" 2>/dev/null \
  || python3 -m pip install --user --break-system-packages openpyxl >/dev/null
python3 - <<'PY'
import csv, openpyxl
wb = openpyxl.Workbook()
ws = wb.active
with open("sample.csv") as f:
    for row in csv.reader(f):
        ws.append(row)
wb.save("sample.xlsx")
PY

# IPYNB — minimal valid notebook.
cat > sample.ipynb <<'EOF'
{
 "cells": [
  {"cell_type": "markdown", "metadata": {}, "source": ["# Sample notebook\n"]},
  {"cell_type": "code", "execution_count": null, "metadata": {}, "outputs": [], "source": ["print('hello')\n"]}
 ],
 "metadata": {"kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"}},
 "nbformat": 4, "nbformat_minor": 5
}
EOF

# PNG — 1x1 generated via ImageMagick.
convert -size 16x16 xc:steelblue sample.png

# SVG — written directly.
cat > sample.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"><rect width="16" height="16" fill="steelblue"/></svg>
EOF

rm -f _source.md _source.pdf
echo "Fixtures generated."
ls -1 sample.*
