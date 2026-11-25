#!/usr/bin/env bash
# Copies templates/project/CLAUDE.md into a project. NEVER overwrites an existing file.
# Usage: scripts/init-project.sh <project-folder>
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"

[ -n "$TARGET" ] || { echo "Usage: $0 <project-folder>"; exit 1; }
[ -d "$TARGET" ] || { echo "Folder not found: $TARGET"; exit 1; }
TARGET="$(cd "$TARGET" && pwd)"

dest="$TARGET/CLAUDE.md"
if [ -e "$dest" ]; then
  echo "skipped (already exists): CLAUDE.md"
else
  cp "$REPO/templates/project/CLAUDE.md" "$dest"
  echo "created: CLAUDE.md"
fi
