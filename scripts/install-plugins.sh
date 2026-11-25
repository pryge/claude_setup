#!/usr/bin/env bash
# Встановлює плагіни, які описані в README. Можна запускати повторно: вже встановлені пропускає.
#   scripts/install-plugins.sh
# Потрібно: Claude Code з командою `claude` у PATH (або CLAUDE_BIN=/шлях/до/claude).
# Скрипт не чіпає твої проєкти і не змінює налаштувань, крім того, що робить сам `claude plugin`.
set -uo pipefail

CLAUDE_BIN="${CLAUDE_BIN:-claude}"

command -v "$CLAUDE_BIN" >/dev/null 2>&1 || {
  echo "Не знайшов '$CLAUDE_BIN'. Встанови Claude Code або запусти так: CLAUDE_BIN=/шлях/до/claude $0"
  exit 1
}

echo "Версія: $("$CLAUDE_BIN" --version 2>/dev/null || echo 'невідома')"
echo "(ponytail потребує Claude Code 2.1.290 або новішої версії)"
echo

# Маркетплейси, яких немає у Claude Code за замовчуванням. Якщо вже додані, помилка безпечна.
add_marketplace() {
  echo "== маркетплейс: $1"
  "$CLAUDE_BIN" plugin marketplace add "$1" || echo "   (вже додано або не вдалося, перевір вручну)"
}

# Сам плагін. Якщо вже встановлений, Claude Code сам повідомить про це.
install_plugin() {
  echo "== плагін: $1"
  "$CLAUDE_BIN" plugin install "$1" || echo "   (вже встановлено або не вдалося, перевір /plugin)"
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
echo "Готово. Далі:"
echo "  1. Перезапусти Claude Code, щоб плагіни завантажилися."
echo "  2. У папці проєкту запусти /impeccable init і /setup-matt-pocock-skills (раз на проєкт)."
echo "  3. Перевір: /plugin або \`$CLAUDE_BIN plugin list\`."
