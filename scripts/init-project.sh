#!/usr/bin/env bash
# Копіює templates/project/CLAUDE.md у проєкт. НІКОЛИ не перезаписує наявний файл.
# Використання: scripts/init-project.sh <папка-проєкту>
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"

[ -n "$TARGET" ] || { echo "Використання: $0 <папка-проєкту>"; exit 1; }
[ -d "$TARGET" ] || { echo "Папки немає: $TARGET"; exit 1; }
TARGET="$(cd "$TARGET" && pwd)"

dest="$TARGET/CLAUDE.md"
if [ -e "$dest" ]; then
  echo "пропуск (вже є): CLAUDE.md"
else
  cp "$REPO/templates/project/CLAUDE.md" "$dest"
  echo "створено: CLAUDE.md"
fi
