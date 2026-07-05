# [PROJECT-NAME]

<!--
  CLAUDE.md is YOUR file. Allostat only manages the single fenced region below,
  between the `BEGIN allostat` and `END allostat` markers. Everything outside the
  markers is yours — `allostat init` never reads or edits it.

  On update, `allostat init` reconciles the managed region in place (it replaces
  what's between the markers, not the whole file).

  Fresh project? This whole file is the scaffold; write your project overview above
  or below the managed region. Existing CLAUDE.md? `allostat init` inserts the
  managed region after your H1 and leaves the rest untouched.
-->

<!-- Add your own project overview, instructions, or notes here. -->

<!-- BEGIN allostat (managed — edits here are overwritten on `allostat init`) -->

This region is contributed by Allostat. It declares this as an Allostat project and lists the project-scope files Claude loads each session. Architectural background for this pattern lives in the methodology's `README.md` — not duplicated here.

## This is an Allostat project

The project's context lives in the `allostat/` files below. At session start, load them and follow `allostat/workflow.md` — its open routine runs the drift + session-log-freshness checks before work begins. Your own Custom Instructions apply as they always do: Allostat is project-scoped and neither requires nor manages your personal/global layer.

## Project-scope `@`-imports

These files are loaded into every session for [PROJECT-NAME]:

@allostat/project-instructions.md
@allostat/workflow.md
@allostat/plan.md
@allostat/decisions.md
@allostat/observations.md
@allostat/vision.md

Loaded when relevant (optional):

@allostat/knowledge/environment.md

<!-- END allostat (managed) -->
