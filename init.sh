#!/bin/sh
# allostat init — places the allostat/ template files into a project.
# Mechanical only, by design: this script fetches REAL files and puts them in
# the RIGHT place. The walkthrough that fills them stays in workflow.md's
# first-run routine (greenfield) or its migrate branch (existing project) —
# run by whatever AI surface you use. Automate the mechanical; gate the meaningful.
#
# Usage:
#   From a clone of allostat/allostat:   ./init.sh /path/to/your-project
#   Without cloning (public repo):       curl -fsSL https://raw.githubusercontent.com/allostat/allostat/main/init.sh | sh -s -- /path/to/your-project
set -eu

REPO_TARBALL="https://github.com/allostat/allostat/archive/refs/heads/main.tar.gz"
BOILERPLATE="templates/project-boilerplate"

TARGET="${1:-}"
[ -n "$TARGET" ] || { echo "usage: init.sh /path/to/your-project" >&2; exit 1; }
[ -d "$TARGET" ] || { echo "error: $TARGET is not a directory" >&2; exit 1; }

# --- Guard: the collision case. If target/allostat exists and looks like the
# TOOL's repo (has templates/ or concepts.md), the adopter cloned the tool into
# the project — the #1 observed setup mistake. Refuse loudly with the fix.
if [ -d "$TARGET/allostat" ]; then
  if [ -d "$TARGET/allostat/templates" ] || [ -f "$TARGET/allostat/concepts.md" ]; then
    echo "STOP: $TARGET/allostat contains the Allostat tool's own repo, not project files." >&2
    echo "The allostat/ folder inside a project is reserved for the project's canonical files." >&2
    echo "Move the tool's clone elsewhere (e.g. ~/allostat-repo), then re-run." >&2
    exit 2
  fi
  echo "STOP: $TARGET/allostat already exists — refusing to overwrite." >&2
  echo "If this is a partial setup, remove or rename it and re-run." >&2
  exit 2
fi

# --- Locate real template files: prefer a local clone (script run from repo),
# else fetch the tarball. NEVER generate or reconstruct files — if we can't
# get real ones, we stop. (An AI reconstructing these files from a README is a
# known failure mode; this script exists partly so that never has to happen.)
SRC=""
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ -d "$SCRIPT_DIR/$BOILERPLATE" ]; then
  SRC="$SCRIPT_DIR/$BOILERPLATE"
else
  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT
  echo "fetching templates from allostat/allostat..."
  curl -fsSL "$REPO_TARBALL" | tar -xz -C "$TMP" || {
    echo "error: could not fetch the repo. Do NOT let an AI reconstruct these files" >&2
    echo "from documentation — get the real repo (clone or ZIP) and re-run from it." >&2
    exit 3
  }
  SRC=$(find "$TMP" -maxdepth 4 -type d -name project-boilerplate | head -1)
  [ -n "$SRC" ] || { echo "error: boilerplate not found in fetched repo" >&2; exit 3; }
fi

# --- Place files.
cp -R "$SRC/allostat" "$TARGET/allostat"

# CLAUDE.md: never overwrite an existing one — the managed block gets added by
# hand (or by your AI, gated) per the template's own instructions.
if [ -f "$TARGET/CLAUDE.md" ]; then
  cp "$SRC/CLAUDE.md" "$TARGET/allostat/CLAUDE.md.allostat-block"
  CLAUDE_NOTE="existing CLAUDE.md left untouched — the Allostat block to add is at allostat/CLAUDE.md.allostat-block"
else
  cp "$SRC/CLAUDE.md" "$TARGET/CLAUDE.md"
  CLAUDE_NOTE="CLAUDE.md placed (Claude Code manifest; harmless on other surfaces)"
fi

# --- Verify: every expected file landed.
MISSING=""
for f in project-instructions.md plan.md decisions.md observations.md vision.md workflow.md knowledge/resources.md knowledge/environment.md; do
  [ -f "$TARGET/allostat/$f" ] || MISSING="$MISSING $f"
done
[ -z "$MISSING" ] || { echo "error: placement incomplete, missing:$MISSING" >&2; exit 4; }

# --- Detect mode for the walkthrough handoff.
MODE="greenfield"
for probe in README.md docs .cursorrules PLAN.md src; do
  [ -e "$TARGET/$probe" ] && MODE="existing" && break
done

echo ""
echo "allostat/ placed in $TARGET  ($CLAUDE_NOTE)"
echo ""
echo "Next steps (the files take it from here):"
echo "  1. Point your project at the files — paste this block into your"
echo "     project's instructions (the Project Instructions field in Claude"
echo "     Desktop, or your surface's equivalent). Using Claude Code? Skip"
echo "     this — the placed CLAUDE.md does it."
echo ""
echo "     ----- copy from here -----"
# Keep VERBATIM in sync with the README's "Point your project at the files"
# block (the parity test checks all three installers print it):
echo "     This is an Allostat project. The canonical files in its \`allostat/\`"
echo "     folder — \`project-instructions.md\`, \`workflow.md\`, \`plan.md\`,"
echo "     \`decisions.md\`, … — are the source of truth. At the start of a"
echo "     session, read them, follow \`workflow.md\`, treat them as authoritative,"
echo "     and flag anything stale rather than just following it."
echo "     ----- copy to here -----"
echo ""
if [ "$MODE" = "existing" ]; then
  echo "  2. This looks like an EXISTING project. In your first session, Claude should"
  echo "     follow workflow.md's 'First run — existing project (migrate)' branch:"
  echo "     it walks YOU through each file, drawing on your current docs — it must"
  echo "     not silently bulk-fill them. If it starts writing files without you,"
  echo "     stop it and point it at that branch."
else
  echo "  2. Fresh project: your first session runs workflow.md's first-run setup —"
  echo "     Claude proposes, you keep/change/drop, file by file."
fi
echo "  3. Confirm it took: new conversation, ask 'where do things stand?'"
