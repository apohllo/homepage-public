#!/usr/bin/env bash
# Convert Textile code blocks to Markdown fenced code blocks.
# Textile: code(lang).\n<body>\n  →  ```lang\n<body>\n```
# Run from anywhere; operates on content/ relative to this script's repo root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTENT="$REPO_ROOT/content"

find "$CONTENT" -name "*.md" -print0 | xargs -0 perl -0777 -i -pe '
  s/^code\(([^)]+)\)\.\n((?:(?![ \t]*\n).+\n)+)/```$1\n$2```\n/mg;
  s/^code\.\n((?:(?![ \t]*\n).+\n)+)/```\n$1```\n/mg;
'

echo "Done."
