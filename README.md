# claude-setup

Плагіни для Claude Code і шаблон `CLAUDE.md` для проєктів на сайтах. Тут немає власних скілів: усе, що потрібно, приходить із плагінів.

Мова: Claude відповідає українською (це задано в `templates/project/CLAUDE.md`), код і технічні терміни англійською.

## 1. Встановлення (один раз на комп'ютер)

Потрібні: Claude Code (з командою `claude` у терміналі) і `git`. Версія Claude Code не нижче 2.1.290 (для ponytail).

**Одна команда** (у терміналі, не в Claude Code):

```bash
git clone https://github.com/pryge/claude_setup.git ~/claude-setup && ~/claude-setup/scripts/install-plugins.sh
```

Скрипт ставить усі шість плагінів. Його можна запускати повторно: уже встановлені він пропускає. Якщо `claude` не в PATH, вкажи шлях: `CLAUDE_BIN=/шлях/до/claude ~/claude-setup/scripts/install-plugins.sh`.

Після цього перезапусти Claude Code і зроби два кроки (тільки раз, див. розділ 3): `/impeccable init` і `/setup-matt-pocock-skills` у папці проєкту.

Якщо скрипт не працює, ті самі команди вручну в Claude Code:

```text
/plugin marketplace add addyosmani/agent-skills
/plugin install agent-skills@addy-agent-skills

/plugin marketplace add pbakaus/impeccable
/plugin install impeccable@impeccable

/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail

/plugin install mattpocock-skills@claude-plugins-official

/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill

/plugin install context7@claude-plugins-official
```

Потім перезапусти Claude Code. Перевірити: `/plugin` або в терміналі `claude plugin list` (усі шість мають бути `enabled`).

Плагіни зберігаються в `~/.claude`, а не в цьому репо.

## 2. Що куди

| Плагін | Для чого | Як викликати | Коли |
|---|---|---|---|
| **agent-skills** | Процес: спека, план, TDD, дебаг, ревʼю, безпека, запуск | Частина скілів спрацьовує сама за описом. Список: `/` у Claude Code | Нова фіча, баг, перед деплоєм |
| **impeccable** | Дизайн і якість фронтенду | `/impeccable critique`, `/impeccable polish`, `/impeccable audit` тощо. Повний список: `/impeccable` без аргументів | Є готова сторінка або компонент, який треба покращити |
| **ponytail** | Економія токенів | `/ponytail-help`, `/ponytail-gain` (скільки зекономлено), `/ponytail-audit` | Коли сесії стають дорогими |
| **mattpocock-skills** | Прототипи, дослідження, словник, модулі, плани | `/grill-me`, `/prototype`, `/research`, `/domain-modeling`, `/tdd`, `/diagnosing-bugs`, `/handoff` | Див. розділ 3 |
| **ui-ux-pro-max** | База дизайну: палітри, пари шрифтів, стилі, UX-правила | `/design`, `/design-system`, `/ui-styling`, `/brand` | Вибір стилю і кольорів, перед версткою |
| **context7** | Актуальна документація бібліотек | Додай до запиту `use context7`, наприклад: `use context7, як у Prisma зробити вкладену вибірку` | Коли не впевнений у синтаксисі або версії |

Назви в колонці «Як викликати» — з описів скілів. Якщо команда не знайдена, відкрий `/` і шукай за словом.

## 3. Сценарії

**Новий проєкт**
1. `scripts/init-project.sh ~/Programming/назва` (створює `CLAUDE.md`, нічого не перезаписує).
2. У Claude Code, у папці проєкту: `/setup-matt-pocock-skills`. Скіли mattpocock (`/to-spec`, `/triage` тощо) без цього не знають, де трекер задач і де `GLOSSARY.md`. Запускай один раз на проєкт.
3. Для сайтів: `/impeccable init`. Створить `PRODUCT.md` (що за продукт і для кого) і `DESIGN.md` (стиль). Заповни їх своїми словами, бо від цього залежать усі наступні дизайн-поради.

**Нова фіча**
1. `/grill-me` — Claude ставить питання про план, поки не стане ясно.
2. Спека і план: скіл `spec-driven-development` або `planning-and-task-breakdown` з agent-skills (або `/to-spec` з mattpocock).
3. Реалізація test-first: `/tdd` або `test-driven-development`.
4. Перед здачею: `code-review-and-quality`, потім `/impeccable critique`, якщо є UI.

**Баг або повільний сайт**
- `/diagnosing-bugs` (цикл: відтворити, знайти причину, перевірити) або `debugging-and-error-recovery` з agent-skills.

**Дизайн сторінки**
1. `/design` або `/design-system` з ui-ux-pro-max: вибрати стиль, палітру, шрифти.
2. Записати рішення в `DESIGN.md`.
3. Верстка, потім `/impeccable critique` (зауваження) і `/impeccable polish` (доведення до ладу).

**Не впевнений у бібліотеці**
- `use context7` у запиті. Наприклад: `use context7, Jest: як мокати модуль з default export`.

**Прототип, щоб перевірити ідею**
- `/prototype` — одноразовий код, щоб відповісти на одне питання про інтерфейс або логіку. Не лишай його в основній гілці.

**Коли нічого з цього не треба**
- Дрібна правка, перейменування, одна стрічка. Просто попроси Claude зробити. Скіли додають токени на кожну сесію, тому не запускай процес там, де він не потрібен.

## 4. Де що лежить

| Що | Де | Хто створює |
|---|---|---|
| Плагіни і їхні налаштування | `~/.claude/settings.json`, `~/.claude/plugins/` | `/plugin install` |
| Правила для проєкту (мова, стек, команди) | `CLAUDE.md` у корені проєкту | `scripts/init-project.sh`, потім ти |
| Опис продукту і стиль | `PRODUCT.md`, `DESIGN.md` у корені проєкту | `/impeccable init` |
| Словник термінів і рішення | `GLOSSARY.md`, `docs/adr/` у проєкті | `/setup-matt-pocock-skills`, `/domain-modeling` |

Нічого з плагінів не копіюється в проєкт. Вони працюють у всіх проєктах одразу.

## 5. Керування

```text
/plugin                                  список і вимикачі
claude plugin disable <name>@<market>    вимкнути без видалення
claude plugin update <name>@<market>     оновити до останньої версії
claude plugin uninstall <name>@<market>  видалити
claude plugin details <name>@<market>    скільки токенів займає опис
```

Оновлення роби вибірково і перевіряй, що змінилось, бо плагіни запускають код.

## 6. Відомі ризики

- **impeccable** запускає бінарник на кожну правку файлу і завантажує його при першому запуску. Я його не перевіряв.
- **ponytail** має хуки в кожній сесії й записує CSV на диск.
- **context7** відправляє назви бібліотек і запити до зовнішнього сервісу. Не вставляй туди ключі, паролі чи приватний код.
- Усі плагіни запускаються з твоїми правами. Ставити лише те, чому довіряєш.
- Скіли не роблять код правильним. Запускай тести, читай diff, і якщо чогось не розумієш, попроси Claude пояснити.

## 7. Файли в цьому репо

```text
scripts/install-plugins.sh    встановлює всі шість плагінів однією командою
scripts/init-project.sh       копіює шаблон CLAUDE.md у проєкт, не перезаписує
templates/project/CLAUDE.md   шаблон правил для проєкту
docs/COMMANDS.md              довідник усіх команд і скілів (таблиці)
LICENSE                       MIT, тільки для файлів цього репо
THIRD_PARTY_LICENSES.md       ліцензії плагінів, які ставить скрипт
```

Повний довідник команд, що кожна робить і коли використовувати, — в [docs/COMMANDS.md](docs/COMMANDS.md).

## Джерела і ліцензії

- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills), MIT
- [pbakaus/impeccable](https://github.com/pbakaus/impeccable), Apache-2.0
- [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail), MIT
- [mattpocock/skills](https://github.com/mattpocock/skills), MIT
- [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill), MIT
- [upstash/context7](https://github.com/upstash/context7), Apache-2.0

Файли цього репо — MIT ([LICENSE](LICENSE)). Повні тексти ліцензій плагінів — у [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
