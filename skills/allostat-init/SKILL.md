---
name: allostat-init
description: Set up Allostat in a project — new or existing. Use when a user asks to install, set up, adopt, or migrate a project onto Allostat, or asks to "run" the Allostat repo. Places the real template files, then hands off to workflow.md's first-run or migrate routine.
---

# allostat-init — the conversational on-ramp

You are helping a person set Allostat up in their project. Allostat is not a
runnable app: it is a folder of canonical context files plus session routines.
"Installing" it means (1) placing the real template files, (2) deploying a
pointer, (3) walking the person through filling the files. This skill covers
the whole flow; the file-filling detail lives in `workflow.md` and stays
authoritative there.

## Hard rules (these outrank helpfulness)

1. **Never reconstruct the template files from a README, from memory, or from
   this skill.** If you cannot reach the real files (repo clone, ZIP, or
   `init.sh`), STOP and tell the person how to get them. A fabricated template
   set looks identical to a real one and silently forks the methodology —
   offering to "recreate the files from the description" is the known failure
   mode this rule exists for.
2. **The project's `allostat/` folder is reserved** for that project's own
   canonical files. If the tool's repo has been cloned there (look for
   `templates/` or `concepts.md` inside it), flag the collision and help move
   it out before placing anything.
3. **Placement is mechanical; filling is gated.** Prefer `init.sh` for
   placement (it fetches real files and verifies). Never fill the files by
   bulk-writing — the walkthrough in `workflow.md` is where content gets made,
   with the person approving file by file.

## Flow

1. **Establish what they have.** A fresh/empty project → greenfield. Real
   content (code, README, docs, rules files) → migrate. Say which path you're
   on and why.
2. **Place the files** — in preference order:
   - Run `init.sh` (from their clone, or the curl one-liner in the README) if a
     shell is available. It handles the collision guard and verification.
   - No shell (e.g. a files-only surface): have the person get the repo (clone
     or Download ZIP) and copy `templates/project-boilerplate/allostat/` into
     the project root, plus the `CLAUDE.md` handling per rule below. Verify
     yourself afterward: list `allostat/` and confirm the eight core files
     `init.sh` verifies (`project-instructions.md`, `plan.md`, `decisions.md`,
     `observations.md`, `vision.md`, `workflow.md`, `knowledge/resources.md`,
     `knowledge/environment.md`) plus the two folder READMEs
     (`knowledge/docs/README.md`, `skills/README.md`).
   - `CLAUDE.md`: never overwrite an existing one — add Allostat's managed
     block to it instead.
3. **Deploy the pointer.** The README's pointer block goes into the project's
   instructions field (or `CLAUDE.md` handles it on Claude Code). Confirm with
   the person where it landed — this surface-specific step is where setups
   silently fail.
4. **Hand off to the canonical routine.** Greenfield → `workflow.md` "First run
   — set up the files." Migrate → `workflow.md` "First run — existing project
   (migrate)". Follow it as written — it is the source of truth for the
   walkthrough, including the mandatory cross-check for silently dropped
   content on the migrate path.
5. **Confirm it took.** Have the person start a fresh conversation and ask
   "where do things stand?" — orientation from the files is the success test.

## What good looks like

The person ends with: real (not reconstructed) files in `allostat/`, filled
through their own keep/change/drop calls, a deployed pointer, a recorded
migration map if they migrated, and a fresh session that orients unaided.
