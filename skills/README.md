# Skills layer

Layer-4 skills documentation for the Allostatik methodology. A skill is a reference note Claude reads when working in a project: what a tool or capability is, how it's set up, how it behaves, and when to use it.

Skills are *what Claude can do and how it works with your tools* — distinct from *what Claude knows* (Layer 3, `knowledge/`) and *which surface Claude runs on* (Layer 5).

In your own projects, skills live in `allostatik/skills/` (see that folder's README in the project boilerplate). This page is the concept doc; the copy-this starting point is `templates/skill_template.md`. The template ships no filled-in skills — you write your own.

## What a skill is here

A skill is a folder with a `SKILL.md` inside it. The `SKILL.md` opens with a small header, then a plain-markdown body:

```
---
name: filesystem-mcp
description: One or two sentences describing what this skill documents.
discovery: methodology-folder
---

# Title
...body...
```

Header fields:

- **`name`** — the skill's slug; matches the folder name.
- **`description`** — plain documentation of what the skill covers. Write it as a sentence a person would read, not a keyword list tuned for a matcher.
- **`discovery`** — how the skill gets loaded (see below). Default `methodology-folder`; `anthropic-skills` is the opt-in alternative.
- **`compatibility`** *(optional)* — surface or version constraints, if any.

Keep bodies focused (under ~500 lines). A skill may add `scripts/`, `references/`, or `assets/` sub-folders, but only when it actually needs them.

## How loading works

Two models, the first as default:

- **Folder-loading (`discovery: methodology-folder`) — default.** The skill is available because it lives in the project's skills folder. Claude reads it by being pointed at the folder, via an `@`-import, or through whatever context bundle the project loads at session start. These notes describe *a project's* specific setup and quirks, so they're deliberately *not* auto-discovered as general-purpose knowledge.
- **Anthropic auto-discovery (`discovery: anthropic-skills`) — opt-in.** A skill can set this to hand itself to Anthropic's Skills feature, which loads skills automatically by matching their descriptions. Use it only for a note that genuinely should behave like a global, always-available skill. It depends on the surface supporting that feature, so folder-loading stays the universal default.

This format borrows the `SKILL.md` shape from Anthropic's skill-creator but stays lighter on purpose — these are reference notes, not packaged distributable skills. We don't use Anthropic's `.skill` packaging, description-tuning loop, or eval workflow; those serve distribution, not project notes. For the underlying format, see Anthropic's skill-creator docs rather than a copy here.

## Two types

- **Standard (`standard/`)** — tools with public documentation elsewhere (Anthropic, third-party). The `SKILL.md` documents *your project-specific use*: scope configured, activation quirks, surface coverage, deferred items. The product docs live elsewhere; this documents the use, not the tool.
- **Custom (`custom/`)** — capabilities with no public documentation: your own shell commands, scripts, aliases. Here the `SKILL.md` *is* the canonical documentation: where the source lives, what it does, dependencies, why it exists.

The split also matters for portability: `standard/` skills travel (a fork reconfigures them), `custom/` skills are personal (a fork ignores or replaces them).

## Adding a skill

Skills live in a project's `allostatik/skills/` folder, not here. Copy `templates/skill_template.md` to start one; the per-project `allostatik/skills/README.md` has the step-by-step.
