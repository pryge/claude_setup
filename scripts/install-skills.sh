#!/usr/bin/env bash
# Підключає скіли з цього репо в ~/.claude/skills як симлінки:
#   skills/*                  мої власні (learn)
#   vendor/*/skills/*         скопійовані чужі (mattpocock-skills, ui-ux-pro-max)
# Нічого не перезаписує: якщо ім'я вже зайняте, пропускає і каже про це.
# Використання: scripts/install-skills.sh [--copy]   (--copy: копіювати замість симлінка)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
MODE="link"; [ "${1:-}" = "--copy" ] && MODE="copy"

mkdir -p "$DEST"
for src in "$REPO"/skills/*/ "$REPO"/vendor/*/skills/*/; do
  [ -f "$src/SKILL.md" ] || continue
  name="$(basename "$src")"
  target="$DEST/$name"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "пропуск: $target вже існує (нічого не змінено)"
    continue
  fi
  if [ "$MODE" = "copy" ]; then cp -R "$src" "$target"; else ln -s "${src%/}" "$target"; fi
  echo "готово ($MODE): $target"
done
echo "Відкрий нову сесію Claude Code, щоб команди з'явилися."
