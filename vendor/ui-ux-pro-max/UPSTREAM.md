# Upstream
Source: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill (MIT, see LICENSE)
Copied commit: 8db36338810d0942567b97ce439affd1619fcf31 (2026-11-24)
Copied: all 7 skills from .claude/skills (ui-ux-pro-max, design, design-system, ui-styling, brand, banner-design, slides).
Removed: tests/ folders and Python caches.
Edited: skills/ui-ux-pro-max/SKILL.md: replaced ${CLAUDE_PLUGIN_ROOT}/.claude/skills/ with $HOME/.claude/skills/ (15 places), because the copy is a normal skill, not a plugin.
NOTE: design/scripts/{logo,icon,cip}/generate.py call external AI image APIs (atlascloud, muapi, uberllm, Google GenAI) ONLY if you run them with your own API keys. Do not give keys unless you want that.
To update: re-copy from upstream by hand and change the commit above.
