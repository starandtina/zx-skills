# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Claude Code skills repository. Each skill is a self-contained directory that can be installed to
`~/.claude/skills/` to extend Claude Code's capabilities.

## Repository Structure

```
zx-skills/
├── zx-*/              # Each skill is a directory with "zx-" prefix
│   ├── SKILL.md        # Skill definition with YAML frontmatter
│   ├── references/     # Reference docs for complex skills
│   ├── assets/         # Templates, images, scripts
│   └── scripts/        # Helper scripts (bash, node)
├── README.md
└── .gitignore          # Ignores everything except zx-*/ and specific files
```

## Skill Format

Each `SKILL.md` follows this structure:

```yaml
---
name: skill-name
description: 'What this skill does. Use when user says...'
user_invocable: true|false
version: 'x.x.x'
---
# Skill content in markdown...
```

## Skill Inventory

| Skill           | Purpose                                                 | External Dependencies |
| --------------- | ------------------------------------------------------- | --------------------- |
| `zx-card`       | Content → PNG visuals (long cards, infographs, posters) | Node.js + Playwright  |
| `zx-paper`      | Academic paper analysis pipeline                        | None                  |
| `zx-paper-flow` | Paper workflow (paper + card combined)                  | None                  |
| `zx-plain`      | Plain language rewriter                                 | None                  |
| `zx-skill-map`  | Visual overview of installed skills                     | Bash                  |
| `zx-word`       | English word deep-dive                                  | None                  |
| `zx-writes`     | Writing engine for thinking through ideas               | None                  |

## Commands

### Install zx-card Dependencies

`zx-card` requires Playwright for screenshot capture:

```bash
cd zx-card && npm install && npx playwright install chromium
```

### Test zx-skill-map Scanner

```bash
bash zx-skill-map/scripts/scan.sh
```

### Install Skills (for users)

```bash
# Copy all skills to Claude Code
mkdir -p ~/.claude/skills
cp -r zx-* ~/.claude/skills/
```

## Architecture Notes

### Skill Invocation

- Skills with `user_invocable: true` can be triggered via `/skill-name` or natural language
- Trigger phrases are defined in each skill's `description` field
- Skills can call other skills via the Skill tool

### Content Processing Pipeline

Several skills share a common pattern for content ingestion:

- **URL** → WebFetch
- **File path** → Read tool
- **Raw text** → Direct use

### zx-card Architecture

The most complex skill with multiple rendering modes:

1. **HTML Templates**: Stored in `assets/` (long_template.html, infograph_template.html, poster_template.html)
2. **Capture Script**: `assets/capture.js` uses Playwright to screenshot HTML → PNG
3. **Reference Docs**: `references/taste.md` (design guidelines), `references/mode-*.md` (mode-specific instructions)
4. **Output**: PNG files written to `~/Downloads/`

### Shared Conventions

**Org-mode output** (zx-paper, zx-plain, zx-writes):

- Bold: `*text*` (single asterisk, not `**`)
- Filenames: `{timestamp}--{title}__{type}.org`
- Output directory: `~/Documents/notes/`
- Timestamps: `date +%Y%m%dT%H%M%S`

**ASCII Art**:

- Allowed: `+ - | / \ > < v ^ * = ~ . : # [ ] ( ) _ , ; ! ' "`
- Forbidden: Unicode box-drawing characters

## Development Guidelines

- Skills are atomic units—each skill directory is self-contained
- Version numbers are manually maintained in SKILL.md frontmatter
- The `.gitignore` ignores all files by default; explicitly unignore with `!pattern`
- When modifying skill logic, update both the SKILL.md and any referenced files in `references/`

## Testing Changes

After modifying a skill:

1. Copy to `~/.claude/skills/`
2. Restart Claude Code to reload skills
3. Test via natural language trigger or `/skill-name`
