# Allostatik

*Formerly **Allostat** — renamed at 0.3.0.*

**Worth reading first (or right after setup):** [why.md](./why.md) — why it exists and what makes it different — and [concepts.md](./concepts.md), the design reasoning underneath.

**A living context layer** — documents you own that keep your project's AI context sharp, consistent, and current across conversations, context windows, and surfaces, plus the session rituals your AI follows to keep them alive. They grow as your project grows. Setup takes about two minutes; the files do the rest.

Nothing runs: no process, no background service, nothing to start or stop. The files act only when your AI reads them in a session, and removing Allostatik is deleting a folder.

## Get started

You need a project on local storage — a folder or repo where an `allostatik/` directory can live. Language-agnostic.

**1. Add the `allostatik/` files.** One command — every path places the **real** template files. *(If an AI assistant ever offers to recreate these files from this README instead, decline: a reconstructed set looks right and silently forks the methodology. Use the real files.)*

Navigate to your project's root folder in your terminal, then any of these works:

```
curl -fsSL https://raw.githubusercontent.com/allostatik/allostatik/main/init.sh | sh -s -- .
```

with npm:

```
npx allostatik init .
```

or with pip:

```
pip install allostatik && allostatik init .
```

All three fetch the current templates from this repo at install time; the npm and pip packages also carry a bundled copy as an offline fallback. Or fully by hand: get this repo (clone or Download ZIP) and copy `templates/project-boilerplate/allostatik/` into your project root — plus `CLAUDE.md` if you use Claude Code (already have a `CLAUDE.md`? add Allostatik's block to it, don't replace it).

> **Where things go:** the tool's repo and your project's `allostatik/` folder are different things that share a name. Don't clone this repo *into* your project — the `allostatik/` folder inside your project is reserved for your project's own files; every installer checks for this mistake and stops you.

**2. Point your AI at the files.** The simplest start: paste this block into a conversation in your project and go — the first session works from it and helps you make the pointer permanent:

> This is an Allostatik project. The canonical files in its `allostatik/` folder — `project-instructions.md`, `workflow.md`, `plan.md`, `decisions.md`, … — are the source of truth. At the start of a session, read them, follow `workflow.md`, treat them as authoritative, and flag anything stale rather than just following it. If they aren't set up yet, help me set them up — github.com/allostatik/allostatik is the reference.

Its permanent home is your project's instructions (the **Project Instructions** field in Claude Desktop, or your surface's equivalent — using Claude Code? the placed `CLAUDE.md` already does it). The block is only the pointer — the files carry the actual instructions.

**3. Start your first session.** Open a conversation in the project and ask where to start. The pointer you just deployed makes Claude load the files; `workflow.md` runs the rest — it owns the session routines, including this first one. (This works best when your AI can read and write the project's files — Claude Code, Cursor, or Claude Desktop with file access. No file access? `workflow.md` covers paste-based setups; you'll want to be comfortable in the terminal.)

- **Fresh project** → *First run — set up the files*: Claude proposes each file from what you tell it; you keep / change / drop, file by file.
- **Existing project** (most people) → *First run — existing project (migrate)*: Claude inventories what your project already knows — README, planning docs, rules files — then walks *you* through folding it into the files, with a final cross-check so nothing is silently dropped. If Claude starts bulk-filling the files without you, stop it and point it back at that routine in `workflow.md`.

**4. Confirm it took.** Start a fresh conversation and ask "where do things stand?" Claude should load your files and orient — a drift-check, then current state and next work. If it doesn't, the pointer isn't deployed or points at the wrong place.

**Optional, once per account:** one line in your Custom Instructions lets Claude recognize *any* Allostatik project without a per-project pointer doing all the work:

> Some of my projects use a layered context system: canonical files (an `allostatik/` folder, with a `CLAUDE.md` listing what to load) that are the source of truth. When a project has them: load them, treat them as authoritative, follow its `workflow.md` to keep them in sync (drift-check at start, update at close), and flag anything stale rather than following it. If a project doesn't have them, ignore this.

A pointer, not a setup. The routine lives in each project's `workflow.md`.

## What you just installed

Your project's context — purpose, conventions, decisions, environment — now lives in canonical files you own, kept sharp (one source of truth), current (a drift-check at every session edge), and yours (nothing rewrites them without your sign-off). It compounds instead of resetting. The full case is in [why.md](./why.md); the design reasoning is in [concepts.md](./concepts.md).

### The files

Each has one job:

- **`allostatik/project-instructions.md`** — what this project is: purpose, conventions, domain notes. Fill in first.
- **`allostatik/plan.md`** — done / current / next. Read it to resume.
- **`allostatik/decisions.md`** — locked choices and the reasoning. Mark changes, don't delete.
- **`allostatik/observations.md`** — patterns and corrections worth keeping.
- **`allostatik/vision.md`** — where the project's headed at the longer horizon, and why. Optional; leave it thin until there's direction beyond the plan.
- **`allostatik/workflow.md`** — the session routines: open, drift-check, close, handoff, and both first-run paths. Ships as a working default; edit rarely.
- **`allostatik/knowledge/`** — your environment and project references, pointed at rather than copied in.
- **`allostatik/skills/`** — documented capabilities. Optional.
- **`CLAUDE.md`** (project root) — manifest declaring what loads each session; the drift-check reads it. Your project may already have one — **add Allostatik's block, don't overwrite**.

### How a session goes

```mermaid
flowchart TD
    PROJ["Project instructions<br/>point at the files"]
    CF["Canonical files · allostatik/<br/>your project's source of truth"]
    OPEN["Session open<br/>load · drift-check · reconcile"]
    WORK["Work<br/>files are the source of truth · flag drift"]
    CLOSE["Session close<br/>update · re-deploy · handoff"]
    DEP[/"Deployed copies<br/>in your tools"/]
    GATE(["You set the gate"])

    PROJ --> CF
    CF --> OPEN
    OPEN <-. drift-check .-> DEP
    OPEN --> WORK
    WORK --> CLOSE
    CLOSE -. handoff carries to next session .-> OPEN
    GATE -.-> OPEN
    GATE -.-> CLOSE
```

1. **Open** — drift-check, reconcile.
2. **Work.**
3. **Close** — update files, re-deploy, write handoff. You approve each step.

The routines live in your project's `workflow.md`; they also ship as installable skills (this repo's `skills/` folder — `allostatik-open`, `allostatik-close`, `allostatik-checkpoint`) if your surface supports skills. The skills are thin triggers that make your AI run the `workflow.md` routine at the right moment — the files stay the source of truth.

## Status

**Working:** templates, drift-check, close/update, handoffs, the `allostatik` installers on npm and PyPI (fetch-first with a bundled offline fallback, behavior-parity-tested against `init.sh` — including the pointer block they print), `init.sh` (placement + collision guard), the migrate routine for existing projects, and the shipped skills — `allostatik-init` plus the three session-ritual skills (`allostatik-open`, `allostatik-close`, `allostatik-checkpoint`).

**Planned:** cross-surface deploy guides (which field is "project instructions" on each surface — Desktop/Cowork, Cursor, web).

## Migrating from Allostat

0.3.0 renamed the tool and the folder: `allostat/` → `allostatik/`. Existing installs keep working on the old name — nothing breaks by itself — and `allostatik init` refuses to scaffold next to an `allostat/` folder (exit 2, nothing written), so the two generations can't end up side by side.

To migrate a project: with a clean tree, `git mv allostat allostatik`; in `CLAUDE.md`, update the two fence lines (`BEGIN allostat` → `BEGIN allostatik`, same for `END`) and the seven `@allostat/…` imports to `@allostatik/…`; then update `allostat` → `allostatik` inside the folder's own files. Two words must survive that sweep: *allostatic* (the concept) stays as it is, and anything already *allostatik* stays put — replace `allostat` only where it isn't followed by an `i`. Verify: every `@allostatik/…` line in `CLAUDE.md` names a file on disk, and a fresh session orients from the files.

## Feedback

Issues and PRs welcome — templates and docs especially. Your project config stays yours.

## License

MIT.

## Disclaimer

Allostatik is a set of files and conventions for managing the context an AI assistant works from. The assistant's responses are generated, non-deterministic, and may be inaccurate or incomplete — they are the assistant's output, not the author's. Verify anything that matters before relying on it. Allostatik is for general productivity and configuration purposes and is not legal, financial, medical, safety, or other professional advice. You are responsible for how you use it and for any actions taken on your behalf. Provided "as is", without warranty, under the MIT License.
