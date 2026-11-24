#!/usr/bin/env bash
# Копіює шаблон templates/project/ у проєкт. НІКОЛИ не перезаписує наявні файли.
# Використання: scripts/init-project.sh <папка-проєкту> [--with-skills]
#   за замовчуванням копіює лише CLAUDE.md;
#   --with-skills додає ще .claude/skills/{deploy,learn} (звичайно НЕ потрібно: вони вже є глобально).
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TPL="$REPO/templates/project"
TARGET="${1:-}"; WITH_SKILLS="no"; [ "${2:-}" = "--with-skills" ] && WITH_SKILLS="yes"

[ -n "$TARGET" ] || { echo "Використання: $0 <папка-проєкту> [--with-skills]"; exit 1; }
[ -d "$TARGET" ] || { echo "Папки немає: $TARGET"; exit 1; }
TARGET="$(cd "$TARGET" && pwd)"

# find -L розгортає симлінки шаблону (скіли лежать у репо в одному місці)
( cd "$TPL" && find -L . -type f ) | while read -r rel; do
  rel="${rel#./}"
  if [ "$WITH_SKILLS" = "no" ] && [[ "$rel" == .claude/skills/* ]]; then continue; fi
  dest="$TARGET/$rel"
  if [ -e "$dest" ]; then
    echo "пропуск (вже є): $rel"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$TPL/$rel" "$dest"
    echo "створено: $rel"
  fi
done
