---
name: allostat-checkpoint
description: Run Allostat's mid-session capture ritual — checkpoints, side notes, observation candidates, decision locks. Use when the user says "checkpoint" or "side note" in a project with an allostat/ folder, when a choice gets settled in conversation, or when a process friction or pattern worth keeping shows up mid-session. Capture in the moment; don't wait for the close.
---

# allostat-checkpoint — capture the loop while it's running

You are capturing process signal mid-session in an Allostat project. The
routine is NOT in this skill — it is the **Capturing observations and
decisions** section of the project's own `allostat/workflow.md` (and the
definitions of "checkpoint" and "side note" live in the user's global
preferences). Read and follow them as written. This skill makes sure the
capture actually happens — the failure mode it guards against is signal
acknowledged in chat and then lost by close.

## Hard rules (these outrank helpfulness)

1. **The project's `workflow.md` and the user's global preferences are
   authoritative, not this skill.** Thresholds (e.g. observation promotion)
   may be overridden in Part 2's *Working notes*; they apply.
2. **"Checkpoint" means ask first.** Full review of how you're working
   together, or just flag the observation? Don't produce artifacts unprompted.
3. **"Side note" means capture, don't engage.** Acknowledge briefly, add it to
   the session's carries for the close, and return to the flow. No elaborating,
   no pushing back on the observation in the moment.
4. **A mention is not a capture.** Write the candidate down where the close
   will find it (a running carries list is fine mid-session; the close routes
   it to `observations.md` / `decisions.md`). Then *show the loop working* —
   point at the concrete capture and where it lands, don't just thank the user.
5. **A decision locks by being written.** When a choice settles in
   conversation, confirm it's actually settled, then propose the `decisions.md`
   row. Agreement in chat that never becomes a row is not locked — the next
   session won't see it.
6. **Candidates are not promotions.** An observation becomes permanent on
   recurrence (default: three firings across sessions, unless the project sets
   a different threshold) — don't harden a one-off into a rule.

## Flow

1. Identify what fired: checkpoint / side note / settled decision / emerging
   pattern.
2. Read `allostat/workflow.md` **Capturing observations and decisions** (and
   Part 2's *Working notes* for thresholds) if not already loaded.
3. Capture per the routine, show the user where it landed, and return to the
   interrupted work.

## What good looks like

By close time, every mid-session signal exists as a written candidate or a
proposed decision row — nothing lives only in the conversation. The user saw
each capture land at the moment it happened, and the flow of the actual work
barely broke stride.
