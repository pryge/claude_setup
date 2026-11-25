# Commands and skills: reference

How to read this:

- **Command**: what you type in Claude Code, for example `/tdd`.
- **Skill**: a set of instructions. Claude can use a skill by itself when your request matches its description. In that case you do not need to type anything.
- **Manual**: the skill runs only when you type its command. Claude will not pick it by itself.
- **Auto**: Claude picks the skill from its description. You can also type it yourself.
- **Hook**: code that runs automatically on an event (session start, file edit). You do not call it.
- **Command only**: the skill is never picked by Claude, even if you ask in plain words. You must type it.

Descriptions are shortened. If you are not sure what exists, type `/` and the list shows the commands available in your session.

---

## 1. Built-in Claude Code commands

These are commands of Claude Code itself (terminal and Code mode), not plugins.

| Command | What it does |
|---|---|
| `/help` | Shows help for commands |
| `/clear` | Clears the conversation and starts fresh |
| `/compact` | Shortens the conversation to free up context, keeping the important parts |
| `/resume` | Opens an earlier session to continue it |
| `/model` | Chooses the model (for example Sonnet or Opus) |
| `/config` | Opens settings |
| `/permissions` | What Claude may do without asking |
| `/plugin` | Lists plugins; turn them on and off; install new ones |
| `/mcp` | Connected servers (MCP), for example Context7 |
| `/hooks` | Shows the hooks that run automatically |
| `/memory` | Edits memory files such as CLAUDE.md |
| `/init` | Creates a `CLAUDE.md` for the current project by reading the code |
| `/cost` | How many tokens and how much money the session used |
| `/status` | Session state, version, connections |
| `/doctor` | Checks that the installation works |
| `/agents` | Views and creates subagents |
| `/exit` | Quits |

---

## 2. Built-in Claude skills (default)

These skills come with your account. Some need you to sign in to a service (for example Google).

| Skill | Type | What it does | Example |
|---|---|---|---|
| `deep-research` | Auto | Researches a topic across many sources and writes a report | "Research the market for furniture websites in Poland" |
| `docs` | Auto | Creates and edits shareable, commentable documents | "Write a spec document for this feature" |
| `docx` | Auto | Creates and edits Word files (.docx) | "Make a contract in Word format" |
| `pdf` | Auto | Reads, merges, splits, fills in PDFs | "Merge these two PDFs" |
| `pptx` | Auto | Creates and edits PowerPoint presentations | "Make a 5-slide deck" |
| `xlsx` | Auto | Creates and edits Excel and CSV files | "Sum the totals in this table" |
| `google-workspace` | Auto | Works with Google Docs, Sheets, Slides and Drive | "Find the budget file in my Drive" |
| `import-memory` | Auto | Brings memory in from another assistant | "Import my notes from ChatGPT" |
| `morning` | Manual | Morning brief (plan for the day, calendar) | `/morning` |
| `skill-creator` | Auto | Creates and improves your own skills | "Create a skill that checks SEO" |
| `init` | Manual | Creates CLAUDE.md for a project | `/init` |
| `loop` | Manual | Repeats a command on an interval | `/loop 5m /run` |
| `schedule` | Manual | Schedules tasks for later (cloud agents) | `/schedule` |
| `claude-api` | Auto | Reference for the Claude API and SDKs: models, prices, parameters | "How do I stream a Claude API response?" |
| `update-config` | Auto | Edits `settings.json`: permissions, environment variables, hooks | "Allow npm commands without asking" |
| `keybindings-help` | Auto | Changes keyboard shortcuts | "Change the send shortcut" |
| `simplify` | Manual | Checks changed code for simplification (not for bugs) | `/simplify` |
| `code-review` | Manual | Reviews your current changes or a pull request | `/code-review` |
| `security-review` | Manual | Security review of the changes on a branch | `/security-review` |
| `ship` | Command only | Commit, pull request, review, and watches the PR until it is merged. Claude never starts it by itself | `/ship` |
| `steward` | Command only | Watches a PR: CI, conflicts, comments. Does not merge | `/steward` |
| `fewer-permission-prompts` | Manual | Builds a list of permissions so Claude asks less | `/fewer-permission-prompts` |
| `claude-approvals` | Auto | Rules for review checks on GitHub (`.claude/approvals.yml`) | "Add a review check for the api folder" |
| `run` | Auto | Starts your app and checks a change for real | "Start the site and test the form" |
| `dataviz` | Auto | Creates charts and dashboards | "Make a sales chart by month" |
| `artifact-design` | Auto | Design rules for "artifacts" (standalone pages in claude.ai) | Used when publishing pages |
| `artifact-diagramming` | Auto | Diagrams inside artifacts | "Draw a database schema" |
| `artifact-capabilities` | Auto | What artifacts can do: saving state, data | Used together with artifacts |
| `plugin-authoring` | Auto | Changes Claude's own interface (themes, panels, commands) | "Make a color theme for Claude" |
| `built-in-browser` | Auto | Controls the browser built into the app | "Open the site and read the text" |
| `chrome-browser` | Auto | Controls your Chrome through the extension | "Open my mail in Chrome" |
| `computer-use` | Auto | Controls your computer: clicks, typing | "Open Notes and write a list" |

---

## 3. Plugin: agent-skills (development process)

Most skills are Auto. These are the most useful for you.

| Skill | Type | What it does | When |
|---|---|---|---|
| `using-agent-skills` | Auto | Picks which skill fits the task | Start of a session |
| `idea-refine` | Auto | Turns a raw idea into a clear concept | The idea is still vague |
| `interview-me` | Auto | Asks one question at a time until it is clear what you want | You are not sure what you need |
| `spec-driven-development` | Auto | Writes a spec before code | New feature or large change |
| `planning-and-task-breakdown` | Auto | Splits a spec into steps | After the spec |
| `incremental-implementation` | Auto | Writes code in small, verified steps | Change touches several files |
| `test-driven-development` | Auto | Tests first: red, green, refactor | Any logic or bug |
| `debugging-and-error-recovery` | Auto | Finds the cause of an error | Tests fail, build breaks |
| `code-review-and-quality` | Auto | Multi-angle code review | Before merging |
| `frontend-ui-engineering` | Auto | Production-quality, accessible interfaces | Building pages and components |
| `accessibility-engineering` | Auto | Checks WCAG 2.2 AA and fixes issues | Accessibility audit |
| `api-and-interface-design` | Auto | Designs APIs and module boundaries | New endpoints |
| `security-and-hardening` | Auto | Protects against vulnerabilities | User input, login, stored data |
| `performance-optimization` | Auto | Speeds up frontend, backend, queries | Something is slow |
| `browser-testing-with-devtools` | Auto | Tests in a real browser through DevTools | Debugging in the browser |
| `source-driven-development` | Auto | Checks decisions against official documentation | Unfamiliar library |
| `documentation-and-adrs` | Auto | Records decisions; spots outdated docs | Important architecture decision |
| `git-workflow-and-versioning` | Auto | Branch and commit practices | Commits, branches, conflicts |
| `ci-cd-and-automation` | Auto | Sets up build and deploy pipelines | Automation |
| `shipping-and-launch` | Auto | Checklist before production | Before launch |
| `code-simplification` | Auto | Simplifies code without changing behavior | Works but is hard to read |
| `deprecation-and-migration` | Auto | Removes old systems, migrates users | Moving from one implementation to another |
| `context-engineering` | Auto | Sets up the session context | Answer quality drops |
| `doubt-driven-development` | Auto | Has a fresh reviewer challenge decisions | You want assumptions checked |
| `constraint-driven-development` | Auto | Writes a quality contract so the agent does not lower the bar | Keeping standards high |
| `observability-and-instrumentation` | Auto | Logs, metrics, tracing | Before production |

---

## 4. Plugin: mattpocock-skills

| Command | Type | What it does | When |
|---|---|---|---|
| `/setup-matt-pocock-skills` | Manual | Sets up the issue tracker, labels, and where the glossary goes | Once per project |
| `/grill-me` | Manual | A strict interview about your plan until it is clear | Before a feature |
| `/grill-with-docs` | Manual | The same, and it writes ADRs and the glossary | When decisions matter |
| `/grilling` | Auto | The same interview when you say "grill me" | Stress-testing an idea |
| `/domain-modeling` | Auto | Maintains `GLOSSARY.md` and ADRs | New terms or decisions |
| `/tdd` | Auto | TDD: tests first | Logic or a bug |
| `/diagnosing-bugs` | Auto | Loop: reproduce, find the cause, verify | A hard bug |
| `/prototype` | Auto | Throwaway prototype to test one question | An idea without UI yet |
| `/research` | Auto | Research from verified sources, saved as Markdown | Collecting facts |
| `/codebase-design` | Auto | Vocabulary for designing modules | Refactoring a module |
| `/improve-codebase-architecture` | Manual | Finds what to simplify and writes an HTML report | Every few months |
| `/handoff` | Manual | Condenses the conversation into a document for a new session | Before closing a session |
| `/to-spec` | Manual | Turns the current conversation into a spec and publishes it to the tracker | After a discussion |
| `/to-tickets` | Manual | Splits a plan into tickets in the tracker | After a spec |
| `/to-questionnaire` | Manual | Makes a questionnaire for someone else to fill in | When someone else must decide |
| `/triage` | Manual | Sorts incoming issues and PRs | When you have a tracker |
| `/implement` | Manual | Implements a ticket or a spec | After `/to-tickets` |
| `/implement-spec` | Manual | Implements the output of `/to-spec` and `/to-tickets` | After a spec |
| `/wayfinder` | Manual | A large plan as a map of decisions | Work bigger than one session |
| `/retro` | Manual | Retrospective on a session | After a session |
| `/teach` | Manual | Teaches a concept inside the workspace | Not needed unless you want lessons |
| `/ask-matt` | Manual | Suggests which skill fits your situation | You do not know what to pick |
| `/wizard` | Auto | Creates an interactive bash wizard for steps only you can do | Setting up infrastructure |
| `/writing-for-agents` | Auto | Writes instructions for agents (skills, CLAUDE.md) | Editing instructions |

---

## 5. Plugin: impeccable (frontend design)

Format: `/impeccable <command> <target>`. The target is a file or route, for example `/impeccable critique src/app/page.tsx`. Without a target, Claude asks.

| Command | Category | What it does |
|---|---|---|
| `/impeccable init` | Build | Writes product and audience notes into `PRODUCT.md`. Run first |
| `/impeccable document` | Build | Creates `DESIGN.md` from the project code |
| `/impeccable shape [feature]` | Build | Plans the UX and UI before code |
| `/impeccable extract [target]` | Build | Moves repeated styles and components into a design system |
| `/impeccable critique [target]` | Evaluate | UX review with heuristic scores |
| `/impeccable audit [target]` | Evaluate | Technical checks: accessibility, speed, responsiveness |
| `/impeccable polish [target]` | Refine | Final pass before showing |
| `/impeccable bolder [target]` | Refine | Makes a bland design more striking |
| `/impeccable quieter [target]` | Refine | Calms an aggressive or cluttered design |
| `/impeccable distill [target]` | Refine | Removes what is not needed |
| `/impeccable harden [target]` | Refine | Errors, empty states, translations, edge cases |
| `/impeccable onboard [target]` | Refine | First-run flows and empty screens |
| `/impeccable animate [target]` | Enhance | Adds purposeful animation |
| `/impeccable colorize [target]` | Enhance | Adds color to a monochrome interface |
| `/impeccable typeset [target]` | Enhance | Type hierarchy and fonts |
| `/impeccable layout [target]` | Enhance | Spacing, rhythm, hierarchy |
| `/impeccable delight [target]` | Enhance | Personality and memorable details |
| `/impeccable overdrive [target]` | Enhance | Goes past conventional limits |
| `/impeccable clarify [target]` | Fix | Copy, labels, error messages |
| `/impeccable adapt [target]` | Fix | Adapts to devices and screen sizes |
| `/impeccable optimize [target]` | Fix | Interface performance |
| `/impeccable live` | Iterate | Pick elements in the browser and try variants |
| `/impeccable generate [n] [action] [element]` | Iterate | Creates n variants of an element to choose from in the browser |

Order for a new page: `init` → `shape` → (code) → `critique` → `polish`.

---

## 6. Plugin: ui-ux-pro-max (design database)

| Skill | Type | What it does | Example |
|---|---|---|---|
| `ui-ux-pro-max` | Auto | General interface advice, stacks, accessibility | "How do I make this form easier to use" |
| `design` | Auto | Brand, tokens, styles, logos, banners | "Pick a style for a delivery website" |
| `design-system` | Auto | Tokens for colors, spacing, fonts, components | `/design-system buttons` |
| `ui-styling` | Auto | Layouts with Tailwind and shadcn/ui | `/ui-styling product card` |
| `brand` | Auto | Brand voice, visual identity | "Describe the tone of voice for the site" |
| `banner-design` | Auto | Banners for social media and ads | `/banner-design instagram` |
| `slides` | Auto | HTML presentations | `/slides topic, 8 slides` |

---

## 7. Plugin: ponytail (lower token use)

| Command | What it does |
|---|---|
| `/ponytail lite` | Light level |
| `/ponytail full` | Standard level (default in this setup) |
| `/ponytail ultra` | Strictest level |
| `/ponytail off` | Turn off |
| `/ponytail` | Show the current level |
| `/ponytail-help` | Short reference |
| `/ponytail-gain` | How much code and tokens were saved |
| `/ponytail-review` | Reviews changes for bugs, security, unnecessary code |
| `/ponytail-audit` | Audits the whole repo |
| `/ponytail-debt` | Collects `shortcut:` comments into a debt list |
| `/ponytail band on` / `off` | Show or hide the panel above the input box (Claude Code only) |
| `/ponytail band import` | Adds past sessions to the cost board |

---

## 8. Context7 (library documentation)

Not a skill and not a command. Add the words `use context7` to your request.

| Example | What happens |
|---|---|
| `use context7, how do I write a nested select in Prisma` | Claude fetches current Prisma documentation |
| `use context7, Jest: how to mock a module` | Jest documentation |

---

## 9. Quick workflows

| Task | What to type |
|---|---|
| New project | `/init`, then `/setup-matt-pocock-skills`, then `/impeccable init` |
| New feature | `/grill-me` → `spec-driven-development` → `/tdd` → `code-review-and-quality` |
| Bug | `/diagnosing-bugs` |
| New page | `/impeccable shape` → `/design-system` → build → `/impeccable critique` → `/impeccable polish` |
| Unfamiliar library | `use context7` in your request |
| Before merging | `/code-review`, `/security-review`, `/simplify` |
| Commit and PR | `/ship` |
| Not sure what to pick | `/ask-matt` |

---

## Notes

- To see the descriptions of the skills in your session, use `/plugin`, or type `/`.
- Plugin commands may carry the plugin name as a prefix if two names clash.
- This page describes what was installed when it was written. After updates, check the list with `/`.
