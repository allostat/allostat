# Skill Template (Layer 4)

This is a starting template for a new **skill** — a layer-4 reference
note Claude reads when working in a project. Copy the template body
into a new `SKILL.md` inside its own folder: `skills/standard/<slug>/SKILL.md`
for a tool with public docs, or `skills/custom/<slug>/SKILL.md` for
something you built yourself. Fill it in, then add a one-line entry to
`skills/README.md`'s index.

A skill documents *what Claude can do and how it works with a tool* —
not what Claude knows (layer 3) or which surface it runs on (layer 5).
See `skills/README.md` for the layer overview and how loading works.

This template does **not** restate Anthropic's skill-creator format
docs — for the underlying `SKILL.md` mechanics, point at those. This
is the project-side starting point.

Last updated: 2026-05-28 (session 31). Living artifact; updated per the checkpoint
protocol in `global_preferences.md`.

---

## Template body — copy from here

````markdown
---
name: <slug>
description: <One or two plain sentences: what this skill documents and when it's relevant. Write it as documentation a person would read, not a keyword list tuned for a matcher.>
discovery: methodology-folder
# compatibility: <optional — surface/version constraints, e.g. "Claude Desktop + Cursor; macOS". Delete this line if none.>
---

# <Skill Name>

<1–3 sentences: what this capability is and what it gives Claude. For
a standard skill, name the underlying tool — its own docs are
canonical, so don't reproduce them. For a custom skill, this file IS
the canonical doc.>

## Current configuration / setup

<How it's installed, scoped, or wired up in this project. Standard
skills: the specific config you chose (scope, permissions, version) —
not a reinstall guide. Custom skills: where the source lives,
dependencies, how to invoke it.>

## When to use this skill

<The decision rule. When does Claude reach for this vs. an
alternative? Tiered or if/else guidance if the choice is non-obvious.
This is the highest-value section — it's why the note exists.>

## What this does NOT cover

<Boundaries. Adjacent things someone might assume are in scope but
aren't, and where to go instead. Prevents misuse. Omit if there's
nothing worth disclaiming.>

## Known issues

<Bugs, quirks, version-specific gotchas — with detection and
workarounds. Omit if none.>

## Deferred items

<Open follow-ups specific to this skill, each with an explicit trigger
("revisit when X"). Omit if none.>
````

## Notes on filling this in

- **Pick the right folder.** `standard/` for tools with public docs (you document *your use*, not the tool). `custom/` for things you built (this file *is* the canonical doc). The slug is the folder name and the `name` field — keep them identical.
- **`description` is documentation, not bait.** Plain sentences describing what the skill covers. Don't keyword-stuff for triggering — these load by folder, not by matching.
- **Leave `discovery: methodology-folder`** unless the skill genuinely should behave like a global Anthropic skill. `anthropic-skills` opts into auto-discovery and depends on the surface supporting it; folder-loading is the universal default.
- **Sections are a default, not a contract.** The skeleton mirrors the shape of existing skills; drop sections that don't apply and add ones that do. Keep the body under ~500 lines.
- **Add `scripts/`, `references/`, or `assets/` sub-folders only when needed** — not preemptively.
- **Update the index.** Add a one-line entry under Standard or Custom in `skills/README.md`.
- **Don't restate Anthropic's skill-creator docs.** Point at them for `SKILL.md` mechanics; this note is project-specific use.

## When to use standard vs. custom

- **Standard** — a tool, connector, or surface with its own documentation (Anthropic, third-party). Your note captures the project-specific configuration and the when-to-use decision; the product's docs stay canonical.
- **Custom** — a shell command, script, or alias you built that has no docs anywhere else. Your note is the only documentation it has, so it carries source location, behavior, dependencies, and rationale.

## Relationship to `skills/README.md`

`skills/README.md` explains the layer (what a skill is, the two types,
how loading works). This template is the copy-this starting point for
an individual skill. The README is the index and the orientation; the
template is the skeleton. If the format itself changes, both update
together via the checkpoint protocol.
