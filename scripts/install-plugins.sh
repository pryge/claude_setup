#!/usr/bin/env bash
# Installs the plugins listed in the README. Safe to run again: already-installed plugins are skipped.
#   scripts/install-plugins.sh
# Needs: Claude Code with the `claude` command in PATH (or set CLAUDE_BIN=/path/to/claude).
# This script does not touch your projects or settings, except what `claude plugin` does itself.
set -uo pipefail

CLAUDE_BIN="${CLAUDE_BIN:-claude}"

command -v "$CLAUDE_BIN" >/dev/null 2>&1 || {
  echo "Could not find '$CLAUDE_BIN'. Install Claude Code, or run: CLAUDE_BIN=/path/to/claude $0"
  exit 1
}

echo "Version: $("$CLAUDE_BIN" --version 2>/dev/null || echo 'unknown')"
echo "(ponytail needs Claude Code 2.1.290 or newer)"
echo

# Marketplaces that Claude Code does not have by default. If already added, the error is harmless.
add_marketplace() {
  echo "== marketplace: $1"
  "$CLAUDE_BIN" plugin marketplace add "$1" || echo "   (already added, or failed: check by hand)"
}

# The plugin itself. If it is already installed, Claude Code says so.
install_plugin() {
  echo "== plugin: $1"
  "$CLAUDE_BIN" plugin install "$1" || echo "   (already installed, or failed: check /plugin)"
}

add_marketplace addyosmani/agent-skills
install_plugin agent-skills@addy-agent-skills

add_marketplace pbakaus/impeccable
install_plugin impeccable@impeccable

add_marketplace DietrichGebert/ponytail
install_plugin ponytail@ponytail

install_plugin mattpocock-skills@claude-plugins-official

add_marketplace nextlevelbuilder/ui-ux-pro-max-skill
install_plugin ui-ux-pro-max@ui-ux-pro-max-skill

install_plugin context7@claude-plugins-official

echo
echo "Done. Next:"
echo "  1. Restart Claude Code so the plugins load."
echo "  2. In your project folder, run /impeccable init and /setup-matt-pocock-skills (once per project)."
echo "  3. Check: /plugin, or \`$CLAUDE_BIN plugin list\`."
