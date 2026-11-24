#!/usr/bin/env bash
# Set up the skills on this machine. Safe to run again (it never overwrites).
#   scripts/bootstrap.sh                                 link skills + create learning profile
#   scripts/bootstrap.sh --with-understand-anything      also install that optional plugin
# Needs: git. The optional plugin also needs the `claude` CLI.
# Note: skills are symlinks to this folder. If you move or delete this folder, run this script again.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"

echo "== 1/3 linking skills"
"$REPO/scripts/install-skills.sh"

echo "== 2/3 learning profile"
mkdir -p "$HOME/learning"
if [ -e "$HOME/learning/PROFILE.md" ]; then
  echo "kept: ~/learning/PROFILE.md already exists"
else
  cp "$REPO/templates/learning/PROFILE.md" "$HOME/learning/PROFILE.md"
  echo "created: ~/learning/PROFILE.md (edit it: language, level, stack)"
fi

if [ "${1:-}" = "--with-understand-anything" ]; then
  command -v "$CLAUDE_BIN" >/dev/null || { echo "'$CLAUDE_BIN' not found. Set CLAUDE_BIN=/path/to/claude"; exit 1; }
  echo "== 3/3 optional plugin: understand-anything"
  "$CLAUDE_BIN" plugin marketplace add "$REPO" || echo "(marketplace may already exist, ok)"
  "$CLAUDE_BIN" plugin install understand-anything@oleg-setup -s user
else
  echo "== 3/3 skipped optional plugin (add --with-understand-anything to install it)"
fi
echo "Done. Open a new Claude Code session."
