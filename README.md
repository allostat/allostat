# Allostat

As your project grows, Allostat keeps the context your AI works from sharp, consistent, and current.

**Not an app you run** — a folder of files you place in your project, plus session routines your AI follows. Setup takes about two minutes; the files do the rest.

## Get started

You need a project on local storage — a folder or repo where an `allostat/` directory can live — and an AI surface that can read and write files in it: **Claude Code, Cursor, or Claude Desktop with file access**. Language-agnostic.

**1. Add the `allostat/` files.** Two ways — both place the **real** template files. *(If an AI assistant ever offers to recreate these files from this README instead, decline: a reconstructed set looks right and silently forks the methodology. Use the real files.)*

One command, from your project's parent directory:

```
curl -fsSL https://raw.githubusercontent.com/allostat/allostat/main/init.sh | sh -s -- ./your-project
```

Or by hand: get this repo (clone or Download ZIP) and copy `templates/project-boilerplate/allostat/` into your project root — plus `CLAUDE.md` if you use Claude Code (already have a `CLAUDE.md`? add Allostat's block to it, don't replace it).

> **Where things go:** the tool's repo and your project's `allostat/` folder are different things that share a name. Don't clone this repo *into* your project — the `allostat/` folder inside your project is reserved for your project's own files; `init.sh` checks for this mistake and stops you.

**2. Point your project at the files.** Paste this into your project's instructions (the **Project Instructions** field in Claude Desktop, or your surface's equivalent — using Claude Code? skip this; the placed `CLAUDE.md` does it):

> This is an Allostat project. The canonical files in its `allostat/` folder — `project-instructions.md`, `workflow.md`, `plan.md`, `decisions.md`, … — are the source of truth. At the start of a session, read them, follow `workflow.md`, treat them as authoritative, and flag anything stale rather than just following it.

The block is only the pointer — the files carry the actual instructions.

**3. Start your first session.** Open a conversation in the project and ask where to start. The pointer you just deployed makes Claude load the files; `workflow.md` runs the rest — it owns the session routines, including this first one:

- **Fresh project** → *First run — set up the files*: Claude proposes each file from what you tell it; you keep / change / drop, file by file.
- **Existing project** (most people) → *First run — existing project (migrate)*: Claude inventories what your project already knows — README, planning docs, rules files — then walks *you* through folding it into the files, with a final cross-check so nothing is silently dropped. If Claude starts bulk-filling the files without you, stop it and point it at that branch.

**4. Confirm it took.** Start a fresh conversation and ask "where do things stand?" Claude should load your files and orient — a drift-check, then current state and next work. If it doesn't, the pointer isn't deployed or points at the wrong place.

**Optional, once per account:** one line in your Custom Instructions lets Claude recognize *any* Allostat project without a per-project pointer doing all the work:

> Some of my projects use a layered context system: canonical files (an `allostat/` folder, with a `CLAUDE.md` listing what to load) that are the source of truth. When a project has them: load them, treat them as authoritative, follow its `workflow.md` to keep them in sync (drift-check at start, update at close), and flag anything stale rather than following it. If a project doesn't have them, ignore this.

A pointer, not a setup. The routine lives in each project's `workflow.md`.

## What you just installed

Your project's context — purpose, conventions, decisions, environment, the tools your AI can use — lives in canonical files you own. Four things keep it from rotting as the project grows:

- **One source of truth — sharp, consistent.** Not scattered and half-duplicated across settings, not a different config per surface.
- **Drift-check — current.** At session start, each canonical file is compared to the copy deployed wherever you're working (a settings field, a rules file); any gap is reconciled before an old line quietly steers the model wrong.
- **You hold the gate.** Automate the mechanical, gate the meaningful: the routines run themselves — loading, checking, comparing — but nothing rewrites your files or config without your sign-off. That gate is what keeps AI's speed from just shipping mistakes faster.
- **It compounds.** No cold starts, no lost corrections: upkeep is captured, not redone, and the setup improves with use instead of resetting each conversation — including asking whether a principle still fits, not just re-applying it.

A living configuration: decisions and patterns get captured, principles get revised when they stop fitting, layers extend as the work changes. You can only revise what you can see and edit — hence files you own.

**Drift in practice.** You change a convention in canonical `project-instructions.md`; the copy pasted into your project settings still has the old one. Next session Claude follows the stale copy. The drift-check catches the mismatch up front; you reconcile.

### The files

Each has one job:

- **`allostat/project-instructions.md`** — what this project is: purpose, conventions, domain notes. Fill in first.
- **`allostat/plan.md`** — done / current / next. Read it to resume.
- **`allostat/decisions.md`** — locked choices and the reasoning. Mark changes, don't delete.
- **`allostat/observations.md`** — patterns and corrections worth keeping.
- **`allostat/vision.md`** — where the project's headed at the longer horizon, and why. Optional; leave it thin until there's direction beyond the plan.
- **`allostat/workflow.md`** — the session routines: open, drift-check, close, handoff, and both first-run paths. Ships as a working default; edit rarely.
- **`allostat/knowledge/`** — your environment and project references, pointed at rather than copied in.
- **`allostat/skills/`** — documented capabilities. Optional.
- **`CLAUDE.md`** (project root) — manifest declaring what loads each session; the drift-check reads it. Your project may already have one — **add Allostat's block, don't overwrite**.

### How a session goes

```mermaid
flowchart TD
    PROJ["Project instructions<br/>point at the files"]
    CF["Canonical files · allostat/<br/>your project's source of truth"]
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

*(There's a fuller model behind why these files exist and how they compose across surfaces — the design reasoning lives in [`concepts.md`](./concepts.md). You don't need it to use Allostat.)*

## Status

**Working:** templates, drift-check, close/update, handoffs, `init.sh` (placement + collision guard), the migrate branch for existing projects, the `allostat-init` skill.

**Planned:** cross-surface deploy guides (which field is "project instructions" on each surface — Desktop/Cowork, Cursor, web), richer init.

## Feedback

Issues and PRs welcome — templates and docs especially. Your project config stays yours.

## License

MIT.

## Disclaimer

Allostat is a set of files and conventions for managing the context an AI assistant works from. The assistant's responses are generated, non-deterministic, and may be inaccurate or incomplete — they are the assistant's output, not the author's. Verify anything that matters before relying on it. Allostat is for general productivity and configuration purposes and is not legal, financial, medical, safety, or other professional advice. You are responsible for how you use it and for any actions taken on your behalf. Provided "as is", without warranty, under the MIT License.
