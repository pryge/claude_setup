#!/usr/bin/env bash
# One-command setup on a new machine.
#   ./scripts/bootstrap.sh                          link the skills into ~/.claude/skills
#   ./scripts/bootstrap.sh --with-understand-anything   also install that optional plugin
# Needs: git. The optional plugin also needs the `claude` CLI.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"

echo "== 1/2 linking skills"
"$REPO/scripts/install-skills.sh"

if [ "${1:-}" = "--with-understand-anything" ]; then
  command -v "$CLAUDE_BIN" >/dev/null || { echo "'$CLAUDE_BIN' not found. Set CLAUDE_BIN=/path/to/claude"; exit 1; }
  echo "== 2/2 optional plugin: understand-anything"
  "$CLAUDE_BIN" plugin marketplace add "$REPO" || echo "(marketplace may already exist, ok)"
  "$CLAUDE_BIN" plugin install understand-anything@oleg-setup -s user
else
  echo "== 2/2 skipped optional plugin (add --with-understand-anything to install it)"
fi
echo "Done. Open a new Claude Code session."
