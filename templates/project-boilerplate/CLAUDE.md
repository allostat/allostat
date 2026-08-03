# [PROJECT-NAME]

<!--
  CLAUDE.md is YOUR file. Allostatik only manages the single fenced region below,
  between the `BEGIN allostatik` and `END allostatik` markers. Everything outside the
  markers is yours — `allostatik init` never reads or edits it.

  On update, `allostatik init` reconciles the managed region in place (it replaces
  what's between the markers, not the whole file).

  Fresh project? This whole file is the scaffold; write your project overview above
  or below the managed region. Existing CLAUDE.md? `allostatik init` inserts the
  managed region after your H1 and leaves the rest untouched.
-->

<!-- Add your own project overview, instructions, or notes here. -->

<!-- BEGIN allostatik (managed — edits here are overwritten on `allostatik init`) -->

This region is contributed by Allostatik. It declares this as an Allostatik project and lists the project-scope files Claude loads each session. Architectural background for this pattern lives in the methodology's `README.md` — not duplicated here.

## This is an Allostatik project

The project's context lives in the `allostatik/` files below. At session start, load them and follow `allostatik/workflow.md` — its open routine runs the drift + session-log-freshness checks before work begins. Your own Custom Instructions apply as they always do: Allostatik is project-scoped and neither requires nor manages your personal/global layer.

## Project-scope `@`-imports

These files are loaded into every session for [PROJECT-NAME]:

@allostatik/project-instructions.md
@allostatik/workflow.md
@allostatik/plan.md
@allostatik/decisions.md
@allostatik/observations.md
@allostatik/vision.md

Loaded when relevant (optional):

@allostatik/knowledge/environment.md

<!-- END allostatik (managed) -->
