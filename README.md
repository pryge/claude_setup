# claude-setup: мій набір для Claude Code

Особистий репозиторій Олега. Тут: власні скіли (`/learn`, `/deploy`), список плагінів (marketplace), шаблон для нових проєктів і скрипти установки.

**Принцип:** за замовчуванням Claude працює як звичайно (пише код за запитом). Режим вчителя вмикається **лише** командою `/learn`. Деплой лише командою `/deploy`.

---

## 1. Швидкий старт на новій машині (одна команда)

Потрібні: Claude Code CLI (`claude`) і `git`.

```bash
git clone https://github.com/<твій-логін>/claude-setup.git ~/Programming/claude-setup && ~/Programming/claude-setup/scripts/bootstrap.sh
```

Скрипт робить три речі: додає marketplace `oleg-setup`, ставить 3 плагіни (user-scope, тобто для всіх проєктів), підключає `/deploy` і `/learn`. Після цього відкрий **нову** сесію Claude Code.

> На комп'ютері, де плагіни вже стоять (на цьому), `bootstrap.sh` не запускай: вони продублюються. Для нього достатньо `scripts/install-skills.sh` (вже виконано).

Якщо `claude plugin install` пише `Permission denied (publickey)`: marketplace тут налаштований на HTTPS-посилання, тож ключі GitHub не потрібні. Якщо побачиш помилку SSH в іншому репо, виконай один раз:
`git config --global url."https://github.com/".insteadOf git@github.com:`

---

## 2. Що встановлено

| Що | Звідки | Виклик | Токени щосесії* |
|---|---|---|---|
| **mattpocock-skills** (27 скілів) | github.com/mattpocock/skills, MIT | частина автоматично, частина лише `/командою` | ~1650 |
| **ui-ux-pro-max** (7 скілів, дизайн) | github.com/nextlevelbuilder/ui-ux-pro-max-skill, MIT | автоматично, коли просиш дизайн | ~1070 |
| **understand-anything** (9 скілів, граф коду) | github.com/Egonex-AI/Understand-Anything, MIT | `/understand…` | ~1270 |
| **/learn** (мій) | `skills/learn/` | лише `/learn` | майже 0 |
| **/deploy** (мій) | `skills/deploy/` | лише `/deploy` | майже 0 |

\* Цифри з `claude plugin details <назва>`: це те, що додається в **кожну** сесію (описи скілів), навіть якщо ти їх не викликаєш. Разом ≈ **4000 токенів**. Це оцінка самого Claude Code, реальна може відрізнятись. Коли скіл спрацьовує, платиш ще «on-invoke» (див. `plugin details`): наприклад `/understand` це ~27k токенів, бо він запускає цілий конвеєр агентів.

Мої власні `learn` і `deploy` мають `disable-model-invocation: true`: Claude не бачить їх, поки ти не напишеш команду. Окремо я це не вимірював.

**Як зменшити витрати:** якщо граф коду зараз не потрібен, вимкни плагін (-1270 токенів на сесію):
```bash
claude plugin disable understand-anything@understand-anything
claude plugin enable  understand-anything@understand-anything   # повернути
```

### Чи працює це в усіх проєктах?
Так. Плагіни стоять у user-scope (`~/.claude/settings.json`, ключ `enabledPlugins`), скіли `learn`/`deploy` лежать у `~/.claude/skills`. Нічого не треба ставити в кожен проєкт. Винятки:
- `/setup-matt-pocock-skills` (з mattpocock) пише файли в проєкт. Запускай лише там, де сам захочеш.
- `/understand` створює в проєкті папку `.understand-anything/` з графом.

---

## 3. Скіл `/learn`: вчитель

Вмикає режим навчання: Claude перестає писати код за тебе й веде тебе кроками.

```text
/learn useEffect            # навчання за темою
/learn Prisma relations
/learn                      # без теми: запропонує тему за журналом
/learn design               # дизайн: разом обираєте стиль/палітру, HTML і Tailwind пишеш ти
/learn review src/App.tsx   # розбір файлу (твого чи написаного ШІ): що, чому, квіз
/learn stop                 # підсумок і повернення до звичайного режиму
```

**Як проходить урок:**
1. Читає кінець журналу (`tail -n 40 ~/learning/LOG.md`), не весь файл.
2. Якщо настав час повторення (3/7/14 днів), питає по старих темах без підказок.
3. Питає, що ти вже знаєш і навіщо тобі це.
4. Цикл: пояснення → «що виведе цей код?» → вправа, яку **пишеш ти** → відгук («чому ти так зробив?») → питання з пам'яті.
5. Якщо застряг: питання-підказка → підказка → пояснення → рішення (лише якщо попросиш; це фіксується в журналі).

**Журнал:** `~/learning/LOG.md`, не в проєктах. Запис робиться лише в кінці уроку, максимум 3 рядки:
`2026-11-24 | useEffect | level: ok | weak: cleanup | review: 2026-11-27`
Так токени не витрачаються на нотатки, а вивчене не залежить від проєкту. Конспекти (за бажанням) у `~/learning/notes/`.

Ідеї взяті з: вбудованого стилю Learning у Claude Code (`TODO(human)`), qtsone/learning (учень пише код, підказки по сходинках), tutorial-creator (розбір рядок за рядком, квіз), mattpocock `teach` (ціль навчання, повторення).

**Вбудований стиль Learning** (необов'язково): `/output-style` → Learning. Claude пише рутину сам, а в місцях із вибором лишає тобі `TODO(human)`. Я його не вмикав за замовчуванням.

---

## 4. Скіл `/deploy`

```text
/deploy                       # покроково
/deploy https://my-site.com   # одразу з URL для перевірки
```

Кроки (на кожному зупиняється при помилці):
1. `git status` і гілка.
2. Тести (скрипт `test` з package.json; Cypress лише з твого дозволу).
3. Збірка (`build`).
4. Показ змін (`git log`, `git diff --stat`) і питання «Deploy? (yes/no)».
5. **Команда деплою: Claude її не вгадує.** Дивиться у `~/.claude/deploy-commands.json`. Якщо запису немає, показує підказки (vercel.json, netlify.toml…) і питає тебе. Після деплою пропонує зберегти команду для цього проєкту.
6. `curl` на сайт: очікує код 200.

Не робить `git push`/`commit`, не використовує `--force`, не читає `.env`. Формат збереження: `{ "/abs/path/project": { "command": "...", "url": "https://..." } }`. Секрети туди не клади.

---

## 5. Плагіни: що в них є

Виклик плагінних скілів: починай друкувати `/` і шукай за назвою. Повна форма `/<плагін>:<скіл>`, наприклад `/mattpocock-skills:tdd`. Я не перевіряв це в живій сесії, тож якщо скорочена форма не спрацює, використай повну.

### mattpocock-skills (процес розробки)
- **Автоматично (за описом):** `tdd`, `diagnosing-bugs` (пошук причин багів), `code-review`, `codebase-design`, `domain-modeling`, `grilling`, `pr`, `prototype`, `research`, `wizard`, `writing-for-agents`.
- **Лише командою:** `ask-matt` (мапа всіх скілів, почни з нього), `grill-me` (Claude допитує тебе про план), `grill-with-docs`, `to-spec`, `to-tickets`, `triage`, `wayfinder`, `implement`, `implement-spec`, `improve-codebase-architecture`, `setup-matt-pocock-skills`, `retro`, `handoff`, `teach`, `to-questionnaire`, `wait-what`.
- Приклад: «напиши тест для цієї функції спочатку (TDD)»; `/grill-me` перед великою фічею.
- `teach` схожий на `/learn`, але генерує HTML-уроки і не змушує писати код. Для твоєї мети використовуй `/learn`.

### ui-ux-pro-max (дизайн)
Скіли: `ui-ux-pro-max`, `design`, `design-system`, `ui-styling`, `brand`, `banner-design`, `slides`. Спрацьовують, коли просиш про UI. Приклади запитів:
- «Підбери стиль, палітру і шрифти для лендінгу вантажоперевезень, Tailwind»
- «Перевір цей компонент на контраст і відступи»
Щоб **навчатись** дизайну, а не копіювати, використовуй `/learn design`.

### understand-anything (розуміння коду)
- `/understand`: аналізує проєкт і будує граф (дорого, ~27k токенів і цілий конвеєр агентів; запускай свідомо, у потрібному проєкті).
- Далі: `/understand-dashboard`, `/understand-chat`, `/understand-explain`, `/understand-onboard`, `/understand-diff`, `/understand-domain`, `/understand-knowledge`, `/understand-figma`.
- Hooks у плагіна (SessionStart, PostToolUse(Bash)) нічого не роблять, поки в проєкті немає `.understand-anything/config.json` з `autoUpdate: true`. Не вмикай це, якщо не хочеш, щоб Claude сам перебудовував граф після commit.

---

## 6. Шаблон для нових проєктів

```bash
~/Programming/claude-setup/scripts/init-project.sh ~/Programming/мій-новий-проєкт
~/Programming/claude-setup/scripts/init-project.sh ~/Programming/мій-новий-проєкт --with-skills
```

- Копіює `templates/project/CLAUDE.md` (короткий: мова, стек, правила). **Існуючі файли не перезаписує.**
- `--with-skills` додає ще `.claude/skills/{deploy,learn}`. Зазвичай не потрібно: вони вже глобальні. Корисно лише якщо хочеш закомітити їх у проєкт.
- Заповни розділ «Project commands» у CLAUDE.md.

Чому CLAUDE.md короткий: він вантажиться в кожну сесію проєкту, тож кожен рядок коштує токенів.

---

## 7. Як створити власний скіл

1. Створи папку і файл: `skills/мій-скіл/SKILL.md` у цьому репо.
2. Мінімальний вміст:
```markdown
---
name: my-skill
description: Коротко: що робить і коли використовувати (це бачить Claude щосесії, тримай до 1-2 речень).
disable-model-invocation: true   # лише за твоєю командою /my-skill
argument-hint: "[аргумент]"
---
Інструкції для Claude. Аргументи: $ARGUMENTS
```
3. Підключи: `scripts/install-skills.sh` (створить симлінк у `~/.claude/skills`, існуюче не чіпає).
4. Перевір: `claude plugin validate skills`, відкрий нову сесію, друкуй `/my-skill`.

Правила: опис короткий (токени щосесії); `disable-model-invocation: true` для всього, що має запускатись лише тобою; довгі інструкції в самому SKILL.md (вантажаться лише при виклику).

---

## 8. Структура репозиторію

```text
claude-setup/
├── .claude-plugin/marketplace.json   # список плагінів (marketplace «oleg-setup»)
├── skills/{learn,deploy}/SKILL.md    # мої скіли (єдине джерело правди)
├── templates/project/                # шаблон для нових проєктів
│   ├── CLAUDE.md
│   └── .claude/skills/{learn,deploy} # симлінки на skills/ (використовує --with-skills)
├── scripts/
│   ├── bootstrap.sh                  # нова машина: marketplace + плагіни + скіли
│   ├── install-skills.sh             # лише мої скіли в ~/.claude/skills
│   └── init-project.sh               # шаблон у проєкт, без перезапису
└── README.md
```

## 9. Публікація на GitHub (робиш ти, я нічого не пушив)

```bash
cd ~/Programming/claude-setup
git init && git add . && git commit -m "Initial claude-setup"
# створи порожній репо на github.com, потім:
git remote add origin https://github.com/<твій-логін>/claude-setup.git
git push -u origin main
```
Перед пушем перевір `git status`: у `.gitignore` уже є `.claude/settings.local.json`. Секретів у репо немає. Після пушу marketplace можна додати й так: `/plugin marketplace add <твій-логін>/claude-setup`.

---

## 10. Що не вдалося перевірити (чесно)

- Живий виклик `/learn` і `/deploy` у новій сесії: установку, валідацію (`claude plugin validate skills`) і симлінки перевірено, але сама поведінка вчителя не тестувалась на реальному уроці.
- Точні імена скорочених команд плагінних скілів (див. розділ 5).
- Hooks Understand-Anything: `session-start-stale-check.mjs` прочитано майже повністю, `post-tool-use-auto-update.mjs` лише перші ~50 рядків (перевірка команди commit і `autoUpdate`).
- Python-скрипти ui-ux-pro-max (локальний пошук по базі) не читались повністю.
- Реальну вартість токенів показує лише Claude Code; цифри вище це його оцінки.

## 11. Відхилено (і чому)

superpowers (~1400 токенів щосесії + SessionStart-скрипт), agent-skills (~2570), ponytail (3 hooks, пише CSV), caveman (hooks, стискає відповіді), impeccable (бінарник на кожну правку), graphify (CLI з PyPI, не плагін; режим always-on змінює CLAUDE.md), archify (не плагін, мережевий запит), Composio (каталог, потрібен зовнішній MCP). Для навчання: qtsone/learning (лише Go), Tov-learn (курс про ШІ), tutorial-creator (можна додати пізніше: пояснює код, але не змушує писати).
