#!/usr/bin/env bash
# Smoke: install.sh must run twice without errors and without reinstalling.
set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# First run must succeed
DRY_RUN=1 bash "$REPO_DIR/install.sh" >/tmp/install-1.log 2>&1 || { echo "FAIL: first run errored"; cat /tmp/install-1.log; exit 1; }

# All required tools must be on PATH afterwards
for cmd in convert gs soffice pandoc xlsx2csv; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "FAIL: $cmd not on PATH after install"; exit 1; }
done

echo "PASS"
