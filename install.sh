#!/usr/bin/env bash
# One-line installer: clone (or update) this repo, then run scripts/bootstrap.sh.
#   curl -fsSL https://raw.githubusercontent.com/pryge/claude_setup/main/install.sh | bash
# Options (environment variables):
#   CLAUDE_SETUP_DIR   where to clone   (default: ~/claude-setup)
#   CLAUDE_SETUP_REPO  git URL to clone (default: the repo below; set it to use your fork)
# Extra arguments are passed to bootstrap.sh, e.g. bash -s -- --with-understand-anything
set -euo pipefail

REPO_URL="${CLAUDE_SETUP_REPO:-https://github.com/pryge/claude_setup.git}"
DIR="${CLAUDE_SETUP_DIR:-$HOME/claude-setup}"

command -v git >/dev/null || { echo "git is required"; exit 1; }
if [ -d "$DIR/.git" ]; then
  echo "Updating $DIR"
  git -C "$DIR" pull --ff-only
else
  git clone "$REPO_URL" "$DIR"
fi
"$DIR/scripts/bootstrap.sh" "$@"
