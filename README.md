# claude-setup

A small Claude Code setup for building websites with AI while you are still learning to code.

Most of the time you want Claude to just write the thing. Sometimes you want it to teach you instead. This repo gives you both, and lets you switch with one command.

- Normal mode (default): Claude writes code for you, with good engineering habits (test first, find the cause of a bug, design before building) and a design toolkit for the parts that are hard if you are not a designer.
- Teacher mode (`/learn`): Claude stops writing code for you. It explains one step, asks a question, gives you a small exercise, and reviews what you wrote.

It is built for a junior full-stack developer (TypeScript, React/Next.js, NestJS, Prisma, PostgreSQL, Tailwind, Zustand, Three.js, Jest, Cypress), but nothing here is tied to one person. Fork it and change the stack lines.

## Quick start

You need [Claude Code](https://claude.com/claude-code) and `git`.

One line, on any machine:

```bash
curl -fsSL https://raw.githubusercontent.com/pryge/claude_setup/main/install.sh | bash
```

Or step by step (read the script first if you like):

```bash
git clone https://github.com/pryge/claude_setup.git ~/claude-setup
~/claude-setup/scripts/bootstrap.sh
```

Open a new Claude Code session. Type `/` and you should see `learn`, `practice`, `tdd`, `diagnosing-bugs` and the rest of the list below.

What it does:

- Creates symlinks from `~/.claude/skills/<name>` to the folders in this repo. It never overwrites anything that exists, so it is safe to run twice.
- Creates `~/learning/PROFILE.md` (language, level, stack, goal) if you do not have one. `/learn` and `/practice` read it, so you change the language or stack there, not in the skills.
- Does not touch your projects or `settings.json`.

Different folder: `CLAUDE_SETUP_DIR=~/somewhere bash install.sh`. Your own fork: `CLAUDE_SETUP_REPO=<your git url>`. Do not move the folder afterwards, the symlinks point to it; if you do, run `scripts/bootstrap.sh` again.

**Private repo.** If the repo is private, `curl` and `git clone` need you to be signed in to GitHub on that machine (a personal access token over HTTPS, or an SSH key). On a new laptop either sign in first or make the repo public. Nothing in it is secret, but that is your call.

### Update

```bash
cd ~/claude-setup && git pull && scripts/bootstrap.sh
```

Existing skills update through the symlinks. `bootstrap.sh` links any new ones.

### Use it in a project you already have

Nothing to install per project: the skills are global. Open the project in Claude Code and type `/learn` or `/practice`. Optionally add a short `CLAUDE.md` with `scripts/init-project.sh <project folder>` (see below). It will not overwrite yours.

## Try it

Normal mode, nothing special to type:

```text
Write a Jest test first, then implement a debounce hook for my search box.
My Next.js page throws "hydration failed". Diagnose it.
Pick a style, color palette and fonts for a freight-company landing page, Tailwind.
```

Teacher mode:

```text
/learn useEffect
```

Claude asks what you already know, explains one idea, asks what you think a snippet will do, then gives you an exercise that you write yourself. Say "stop" to go back to normal mode.

## What you get

Skills are small instruction files. Claude loads a skill's short description at the start of every session, and reads the full text only when the skill is used.

| Skill | What it does | How it starts |
|---|---|---|
| `learn` | Theory teacher: explains one idea at a time, asks questions, gives small exercises | You type `/learn` (Claude never starts it on its own) |
| `practice` | Mentor for a real task: splits it into steps and gives hints instead of code | You type `/practice` (manual only) |
| `tdd` | Test-first development, red-green-refactor | Automatic, when you ask for test-first work |
| `diagnosing-bugs` | A step-by-step loop for finding the cause of a bug | Automatic, when something is broken or slow |
| `codebase-design` | Vocabulary for splitting code into modules with simple interfaces | Automatic, when you design or refactor a module |
| `domain-modeling` | Keeps a glossary of project terms and records decisions (ADRs) | Automatic, when you talk about naming or decisions |
| `prototype` | Builds a throwaway prototype to answer one design question | Automatic |
| `research` | Reads primary sources and saves findings to a Markdown file | Automatic |
| `grilling` | Claude interviews you about a plan until the gaps show | Automatic, on "grill me" style phrases |
| `grill-me`, `grill-with-docs` | Same interview, started by command; the second also writes docs | You type `/grill-me` |
| `handoff` | Summarizes the conversation so a new session can continue | You type `/handoff` |
| `ui-ux-pro-max` | Searchable local database of styles, palettes, font pairings, UX rules and stack guides | Automatic, when you design or review UI |
| `design`, `design-system`, `ui-styling`, `brand`, `banner-design`, `slides` | The rest of the design toolkit: tokens, shadcn/Tailwind styling, brand, banners, HTML slides | Automatic |

Skills that start automatically can also be called by name: type `/` and the skill name.

## Does this make Claude's code correct?

No. Skills change how Claude works, not how reliable it is. `tdd` and `diagnosing-bugs` make mistakes easier to catch, but Claude can still be wrong. Run the code, run the tests, read the diff. If you do not understand a change, that is a good moment to type `/learn`.

## Learning with `/learn`

```text
/learn useEffect            learn a topic
/learn                      no topic: Claude suggests one from your log
/learn design               pick style and palette together; you write the HTML and Tailwind
/learn review src/App.tsx   walk through a file (yours or AI-written), then a short quiz
/learn stop                 summary, then back to normal mode
```

A lesson goes like this:

1. Claude reads the end of your log and, if something is due, quizzes you on it first with no hints.
2. It asks what you already know and why you need this now.
3. Loop: one short explanation, then "what will this code print?", then an exercise you write yourself, then feedback, then one question from memory.
4. If you are stuck you get a question, then a hint, then an explanation. You only get the solution if you ask for it, and that is noted in the log.

Rules the skill follows: you write the code, one step at a time, no lectures, no files written for you, and it never reads your whole project.

The log is `~/learning/LOG.md`. It is outside your projects, so what you learn follows you everywhere. Entries are written once at the end of a lesson, at most three lines:

```text
2026-11-24 | useEffect | level: ok | weak: cleanup | review: 2026-11-27
```

The review date is how spaced repetition works here: the next `/learn` brings that topic back after 3, then 7, then 14 days.

The skill's instructions are in English; Claude talks to you in Ukrainian. To change that, edit the "Language" line in [skills/learn/SKILL.md](skills/learn/SKILL.md).

The idea comes from Claude Code's built-in Learning output style (`/output-style`), which leaves `TODO(human)` gaps for you, plus ideas from [qtsone/learning](https://github.com/qtsone/learning) and mattpocock's `teach`.

## Practicing with `/practice`

`/learn` teaches an idea. `/practice` helps you build a real thing without AI writing it for you.

```text
/practice landing section 3: six cards move right to left on scroll with GSAP ScrollTrigger
```

1. Claude finds the code itself (it never asks you which file to open). For a tiny change it skips the plan: it shows where the code is, asks one thinking question, you edit, it reviews. For a bigger task it shows a plan of 3 to 6 steps, each with a goal and a way to check it, but no code.
2. For each step it asks how you would approach it, and you write the code in your editor.
3. When you say "done", it reads that file and points to the problem, not the fix. It asks you to explain a line in your own words.
4. If you are stuck it climbs a ladder: a question, then the concept and a docs link, then the structure in words, then a tiny example on a different case. The solution comes only if you ask.
5. Before it hints about a library such as GSAP, it checks the real docs or your installed version.
6. When the task works, it asks one or two growth questions (edge cases, tests, cost, accessibility, simpler options), the kind a mid or senior developer asks. How much help you get is set by `Guidance` in `~/learning/PROFILE.md`: `guided`, `standard` or `spartan`.
7. At the end it lists the gaps it saw and suggests `/learn <concept>` for each, then logs them in the same file as `/learn`.

A good rhythm: build with `/practice`, then close the gaps with `/learn`.

## Start a new project

```bash
scripts/init-project.sh ~/Programming/my-new-project
```

This copies `templates/project/CLAUDE.md` (language, stack, a few rules, and blanks for your run/test/build commands). It never overwrites a file that exists. Keep that file short: it is loaded in every session of that project, so every line costs tokens.

Add `--with-skills` to also copy `learn` into the project's `.claude/skills`. You usually do not need it, because the skills are already global.

## What it costs

Every skill's description is loaded in every session, even if you never use it. Claude Code's own estimate for the same skills (`claude plugin details`) is roughly 650 tokens for the ten mattpocock skills and 1,070 for the seven design skills, so about 1,700 in total. A skill that runs costs more while it runs, usually 1 to 7 thousand tokens. These numbers are estimates from Claude Code, not measurements of this repo. `learn` is manual-only, so its description is not loaded in normal sessions; this was not measured separately.

Your learning log is only read with `tail -n 40` and only when you run `/learn`.

## Add your own skill

1. Make a folder: `skills/my-skill/SKILL.md`
2. Write it:

   ```markdown
   ---
   name: my-skill
   description: One or two sentences: what it does and when to use it.
   disable-model-invocation: true
   argument-hint: "[what to pass in]"
   ---

   Instructions for Claude. Your arguments: $ARGUMENTS
   ```

3. Run `scripts/install-skills.sh`, then check with `claude plugin validate skills`.
4. Open a new session and type `/my-skill`.

Keep the description short, because it is loaded every session. Use `disable-model-invocation: true` for anything that should only run when you ask.

## Optional: understand a codebase

[Understand-Anything](https://github.com/Egonex-AI/Understand-Anything) builds a graph of a project and explains it. It is not installed by default: it adds about 1,300 tokens to every session, `/understand` itself is expensive (about 27k tokens plus several agents), and it is overkill for small sites. To install it:

```bash
scripts/bootstrap.sh --with-understand-anything
```

Its hooks do nothing unless a project has `.understand-anything/config.json` with `"autoUpdate": true`. To turn it off again: `claude plugin disable understand-anything@oleg-setup`.

## Repository layout

```text
skills/learn/, skills/practice/   my own skills
vendor/mattpocock-skills/     10 skills copied from mattpocock/skills (MIT)
vendor/ui-ux-pro-max/         7 skills copied from nextlevelbuilder/ui-ux-pro-max-skill (MIT)
templates/project/            CLAUDE.md for new projects
scripts/bootstrap.sh          new machine: link skills (+ optional plugin)
scripts/install-skills.sh     link skills into ~/.claude/skills, never overwrite
scripts/init-project.sh       copy the project template, never overwrite
.claude-plugin/marketplace.json   lists the one optional plugin
```

## Why the skills are copied, not installed as plugins

A plugin updates itself, so its text, and sometimes its code, can change without you noticing. It also installs all of its skills, and every one costs tokens. Copying gives a fixed version, lets us keep only the skills we use, and means you can read everything that runs.

The price: no automatic fixes. Each copied folder has an `UPSTREAM.md` with the source, the exact commit, and what was changed. To update, re-copy from upstream by hand and update that file.

Two things to know:

- `ui-ux-pro-max/SKILL.md` was edited. The original calls its script through `${CLAUDE_PLUGIN_ROOT}`, which only exists inside a plugin. The copy uses `$HOME/.claude/skills/...` instead.
- The `design` skill ships scripts (`logo`, `icon`, `cip`) that call outside AI image services, but only if you run them and give them your own API keys. Do not add keys unless you want that.

## What was left out, and why

| Candidate | Reason |
|---|---|
| mattpocock `code-review`, `to-spec` | Need the issue-tracker setup from `/setup-matt-pocock-skills`. Claude Code has its own `/code-review`. |
| mattpocock `triage`, `to-tickets`, `wayfinder`, `wizard`, `retro` and others | Team and issue-tracker workflows. |
| mattpocock `teach` | Produces HTML lessons but does not make you write code. `/learn` replaces it. |
| superpowers, agent-skills | About 1,400 and 2,600 tokens per session, and they overlap with the skills above. |
| ponytail, caveman | Hooks on every session and prompt; caveman also shortens answers, which fights with explanations. |
| impeccable | Runs a downloaded binary on every file edit. |
| graphify, archify | Not Claude Code plugins; graphify's always-on mode edits CLAUDE.md and adds a hook. |

This was checked against each repository's README, manifests and hooks. A few files were only skimmed, so read before you trust.

## Known limits

- `/learn` has been installed and validated but not yet tested on a real lesson. Expect to tweak it.
- Short names of plugin commands were not tested because the copied skills are not plugins; use the names in the table above.
- The scripts inside `ui-ux-pro-max` were checked for network and process calls, not read line by line.

## Credits and licenses

My own files (`skills/learn`, `skills/practice`, scripts, templates, docs) are MIT, see [LICENSE](LICENSE). Everything under `vendor/` keeps its original license and copyright, listed below.

- [mattpocock/skills](https://github.com/mattpocock/skills), MIT. License copied to `vendor/mattpocock-skills/LICENSE`.
- [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill), MIT. License copied to `vendor/ui-ux-pro-max/LICENSE`.
- [Egonex-AI/Understand-Anything](https://github.com/Egonex-AI/Understand-Anything), MIT (optional, not copied).
