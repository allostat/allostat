---
name: allostat-open
description: Run the Allostat session-open ritual — load canonical files, drift-check, orient. Use at the start of any session in a project with an allostat/ folder, or when the user asks "where do things stand", "orient", "catch up", "start the session", or opens with a handoff. Do not start substantive work in an Allostat project before this has run.
---

# allostat-open — start the session from the files

You are opening a session in an Allostat project. The routine you are about to
run is NOT in this skill — it is the **Session open** and **Drift-check**
sections of the project's own `allostat/workflow.md`. Read them and follow them
as written. This skill exists to make sure that happens, and to hold the rules
that protect the routine from shortcuts.

## Hard rules (these outrank helpfulness)

1. **The project's `workflow.md` is authoritative, not this skill.** Projects
   customize Part 2 and may log skip rows in `decisions.md`. If this skill and
   the project's files disagree, the files win.
2. **No substantive work before the open completes.** All five open steps, in
   order. The user asking an eager first question does not waive the ritual —
   fold the answer into step 5's proposed starting point.
3. **Every check failure follows the same pattern: halt, surface, ask.** Never
   silently reconcile drift, never guess at a missing file, never proceed on
   assumption.
4. **Drift-check compares what IS, not what you remember.** Re-read the
   canonical file from disk and the deployed surface as it reads now. If a
   deployed surface can't be read back on this surface, say so and carry it as
   a reconcile-before-work item — an un-runnable check is not a passed check.
5. **A stale session log means a skipped close.** If `plan.md`'s newest entry
   is behind reality, backfill it before any new work (workflow.md's
   session-log freshness check says how).

## Flow

1. Locate and read, in order: the handoff (if one exists), then
   `allostat/workflow.md` **Session open** + **Drift-check**, then the files
   they point at (`project-instructions.md`, `plan.md`, and the rest of the
   canonical set).
2. Execute Session open steps 1–5 exactly as the project's copy states them:
   verify capability → read context → drift-check → restate the state in your
   own words → propose a starting point and wait for confirmation.
3. If the handoff carries a "DO BEFORE THIS HANDOFF IS CONSUMED" item, it goes
   first — before the proposed starting point.

## What good looks like

The user gets: any drift surfaced and reconciled (or explicitly carried), a
restatement of where things stand that is yours rather than a paste, and a
proposed first move they confirmed — all before any real work happened.
