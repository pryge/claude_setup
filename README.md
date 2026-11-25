# claude-setup

Plugins and a project template for building websites with Claude Code.

This repo has no skills of its own. Everything comes from plugins, installed from their own marketplaces.

Claude answers in English (see `templates/project/CLAUDE.md`). Code and technical terms are in English.

## 1. Install (once per computer)

You need: Claude Code (with the `claude` command in the terminal) and `git`. Claude Code version 2.1.290 or newer (for ponytail).

**One command** (in your terminal, not inside Claude Code):

```bash
git clone https://github.com/pryge/claude_setup.git ~/claude-setup && ~/claude-setup/scripts/install-plugins.sh
```

The script installs all six plugins. You can run it again: plugins already installed are skipped. If `claude` is not in your PATH, give the path: `CLAUDE_BIN=/path/to/claude ~/claude-setup/scripts/install-plugins.sh`.

Then restart Claude Code and do two one-time steps in each project (see section 3): `/impeccable init` and `/setup-matt-pocock-skills`.

If the script does not work, run these commands by hand inside Claude Code:

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

Plugins are stored in `~/.claude`, not in this repo. Check them with `/plugin` or `claude plugin list`.

- **agent-skills**: development workflow (spec, plan, test-first, debugging, code review, security, shipping).
- **impeccable**: design and frontend quality.
- **ponytail**: lower token use. It asks for optional settings (task board, webhook); leave them empty.
- **mattpocock-skills**: prototypes, research, domain glossary, module design, planning interviews.
- **ui-ux-pro-max**: searchable design database (palettes, font pairs, styles, UX rules).
- **context7**: current library documentation (NestJS, Prisma, Three.js, Jest, Cypress) on request.

Known costs, from the review before installing: impeccable runs a binary on every file edit, and ponytail adds hooks to every session and writes a CSV file to disk. To turn either off, run `/plugin disable <name>`.

## 2. What goes where

| Plugin | What it does | How to use it | When |
|---|---|---|---|
| **agent-skills** | Process: spec, plan, test-first, debugging, review, security, shipping | Most skills run by themselves when your request matches them. To see the list, type `/` | New feature, bug, before deploying |
| **impeccable** | Design and frontend quality | `/impeccable critique`, `/impeccable polish`, `/impeccable audit`, and more. Type `/impeccable` alone for the menu | A page or component exists and needs improving |
| **ponytail** | Lower token use | `/ponytail-help`, `/ponytail-gain` (savings), `/ponytail-audit` | When sessions get expensive |
| **mattpocock-skills** | Prototypes, research, glossary, modules, plans | `/grill-me`, `/prototype`, `/research`, `/domain-modeling`, `/tdd`, `/diagnosing-bugs`, `/handoff` | See section 3 |
| **ui-ux-pro-max** | Design database: palettes, font pairs, styles, UX rules | `/design`, `/design-system`, `/ui-styling`, `/brand` | Choosing a style and colors, before coding the layout |
| **context7** | Current library documentation | Add `use context7` to your request | When unsure about a library's syntax or version |

Every command and skill, with a short explanation, is in [docs/COMMANDS.md](docs/COMMANDS.md).

## 3. Common tasks

**New project**
1. Run `scripts/init-project.sh ~/Programming/your-project`. This creates `CLAUDE.md` and never overwrites an existing file.
2. In Claude Code, inside the project folder, run `/setup-matt-pocock-skills`. The mattpocock skills (`/to-spec`, `/triage`, and others) need it to know where your issues live and where `GLOSSARY.md` goes. Run it once per project.
3. For websites, run `/impeccable init`. It creates `PRODUCT.md` (what the product is and who it is for) and `DESIGN.md` (the visual style). Fill them in with your own words, because all later design advice depends on them.

**New feature**
1. `/grill-me`: Claude asks questions about your plan until it is clear.
2. Spec and plan: the `spec-driven-development` or `planning-and-task-breakdown` skill from agent-skills (or `/to-spec` from mattpocock).
3. Build test-first: `/tdd` or `test-driven-development`.
4. Before you finish: `code-review-and-quality`, then `/impeccable critique` if the change has UI.

**Bug or slow page**
- `/diagnosing-bugs` (loop: reproduce, find the cause, verify), or `debugging-and-error-recovery` from agent-skills.

**Page design**
1. `/design` or `/design-system` from ui-ux-pro-max: choose a style, palette and fonts.
2. Write the decisions into `DESIGN.md`.
3. Build the layout, then `/impeccable critique` (remarks) and `/impeccable polish` (finish).

**Unsure about a library**
- Add `use context7` to your request, for example: `use context7, Jest: how to mock a module with a default export`.

**Prototype to test an idea**
- `/prototype`: throwaway code that answers one question about the interface or logic. Do not leave it in your main branch.

**When you do not need any of this**
- Small edits, renames, one-line fixes: just ask Claude. Skills add tokens to every session, so do not run a full process for a tiny change.

## 4. Where things live

| What | Where | Who creates it |
|---|---|---|
| Plugins and their settings | `~/.claude/settings.json`, `~/.claude/plugins/` | `/plugin install` |
| Project rules (language, stack, commands) | `CLAUDE.md` in the project root | `scripts/init-project.sh`, then you |
| Product and style notes | `PRODUCT.md`, `DESIGN.md` in the project root | `/impeccable init` |
| Glossary and decisions | `GLOSSARY.md`, `docs/adr/` in the project | `/setup-matt-pocock-skills`, `/domain-modeling` |

Nothing from the plugins is copied into your project. They work in all your projects at once.

## 5. Managing plugins

```text
/plugin                                    list and toggle plugins
claude plugin disable <name>@<market>      turn off without removing
claude plugin update <name>@<market>       update to the latest version
claude plugin uninstall <name>@<market>    remove
claude plugin details <name>@<market>      how many tokens the descriptions use
```

Update one plugin at a time and check what changed, because plugins run code.

## 6. Known risks

- **impeccable** runs a binary on every file edit, and downloads it on first run. This setup has not reviewed that binary.
- **ponytail** has hooks in every session and writes a CSV file to disk.
- **context7** sends library names and your queries to an external service. Do not put keys, passwords, or private code in those queries.
- Plugins run with your permissions. Install only what you trust.
- Skills do not make code correct. Run the tests, read the diff, and ask Claude to explain anything you do not understand.

## 7. Files in this repo

```text
scripts/install-plugins.sh    installs all six plugins in one command
scripts/init-project.sh       copies the CLAUDE.md template into a project, never overwrites
templates/project/CLAUDE.md   project rules template (English replies)
docs/COMMANDS.md              reference of all commands and skills (tables)
LICENSE                       MIT, for files in this repo only
THIRD_PARTY_LICENSES.md       licenses of the plugins the script installs
```

## Sources and licenses

- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills), MIT
- [pbakaus/impeccable](https://github.com/pbakaus/impeccable), Apache-2.0
- [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail), MIT
- [mattpocock/skills](https://github.com/mattpocock/skills), MIT
- [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill), MIT
- [upstash/context7](https://github.com/upstash/context7), Apache-2.0

Files in this repo are MIT ([LICENSE](LICENSE)). Full license texts for the plugins are in [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).
