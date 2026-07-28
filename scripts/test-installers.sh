#!/usr/bin/env bash
# test-installers.sh — behavior-parity test for the three install paths:
#   init.sh (shell), installers/npm (node), installers/pip (python).
#
# TDD for the parity invariant: all three must produce identical file trees
# and agree on guards/exit codes. Run after touching any installer or the
# templates. Requires: bash, node >=18, python3 >=3.9. Network NOT required
# (init.sh is exercised from the local checkout, which uses its local-clone path).
#
# Usage: scripts/test-installers.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Parity must compare the LOCAL templates, not whatever is on GitHub main —
# force the bundled path for the npm/pip runs (their fetch-first behavior is
# exercised separately; the fallback path is this same code path).
export ALLOSTAT_OFFLINE=1
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
PASS=0; FAIL=0

say()  { printf '%s\n' "$*"; }
ok()   { PASS=$((PASS+1)); say "  ok    $*"; }
bad()  { FAIL=$((FAIL+1)); say "  FAIL  $*"; }

# --- Assemble runnable copies (mirrors build.sh's bundling step).
NPM_PKG="$WORK/npm-pkg"; PIP_PKG="$WORK/pip-pkg"
cp -R "$ROOT/installers/npm" "$NPM_PKG"
cp -R "$ROOT/installers/pip" "$PIP_PKG"
mkdir -p "$NPM_PKG/templates" "$PIP_PKG/src/allostat/templates"
cp -R "$ROOT/templates/project-boilerplate" "$NPM_PKG/templates/project-boilerplate"
cp -R "$ROOT/templates/project-boilerplate" "$PIP_PKG/src/allostat/templates/project-boilerplate"

run_sh()  { sh "$ROOT/init.sh" "$1"; }
run_npm() { node "$NPM_PKG/bin/allostat.js" init "$1"; }
run_pip() { PYTHONPATH="$PIP_PKG/src" python3 -m allostat.cli init "$1"; }
# init.sh lives at extraction/init.sh canonically but ships at repo root; accept either:
[ -f "$ROOT/init.sh" ] || run_sh() { sh "$ROOT/extraction/init.sh" "$1"; }

tree_of() { (cd "$1" && find . -type f | sort); }

# --- Case 1: greenfield — identical trees across all three.
say "case 1: greenfield parity"
for impl in sh npm pip; do mkdir -p "$WORK/green-$impl"; done
run_sh  "$WORK/green-sh"  >/dev/null
run_npm "$WORK/green-npm" >/dev/null
run_pip "$WORK/green-pip" >/dev/null
T_SH="$(tree_of "$WORK/green-sh")"; T_NPM="$(tree_of "$WORK/green-npm")"; T_PIP="$(tree_of "$WORK/green-pip")"
[ "$T_SH" = "$T_NPM" ] && ok "sh tree == npm tree" || { bad "sh vs npm tree"; diff <(echo "$T_SH") <(echo "$T_NPM") || true; }
[ "$T_SH" = "$T_PIP" ] && ok "sh tree == pip tree" || { bad "sh vs pip tree"; diff <(echo "$T_SH") <(echo "$T_PIP") || true; }
# Content parity, not just names:
if diff -r "$WORK/green-sh" "$WORK/green-npm" >/dev/null && diff -r "$WORK/green-sh" "$WORK/green-pip" >/dev/null; then
  ok "file contents identical across all three"
else
  bad "file contents differ between implementations"
fi
echo "$T_SH" | grep -q './CLAUDE.md' && ok "CLAUDE.md placed on greenfield" || bad "CLAUDE.md missing on greenfield"

# --- Case 2: existing project — CLAUDE.md preserved, block file written, mode detected.
say "case 2: existing-project behavior"
for impl in npm pip; do
  d="$WORK/exist-$impl"; mkdir -p "$d/src"
  printf '# my project\n' > "$d/README.md"; printf 'MINE\n' > "$d/CLAUDE.md"
  out="$( { [ "$impl" = npm ] && run_npm "$d"; } || true; { [ "$impl" = pip ] && run_pip "$d"; } || true )"
  [ "$(cat "$d/CLAUDE.md")" = "MINE" ] && ok "$impl: existing CLAUDE.md untouched" || bad "$impl: CLAUDE.md overwritten"
  [ -f "$d/allostat/CLAUDE.md.allostat-block" ] && ok "$impl: block file written" || bad "$impl: block file missing"
  printf '%s' "$out" | grep -q 'EXISTING project' && ok "$impl: existing mode detected" || bad "$impl: mode detection"
done

# --- Case 3: guards — refuse overwrite (exit 2) and tool-repo collision (exit 2).
say "case 3: guards"
for impl in npm pip; do
  d="$WORK/guard-$impl"; mkdir -p "$d/allostat"
  rc=0; { [ "$impl" = npm ] && run_npm "$d" >/dev/null 2>&1; } || rc=$?
  { [ "$impl" = pip ] && { run_pip "$d" >/dev/null 2>&1 || rc=$?; }; } || true
  [ "$rc" -eq 2 ] && ok "$impl: refuses existing allostat/ (exit 2)" || bad "$impl: overwrite guard (exit $rc)"
  d2="$WORK/guard2-$impl"; mkdir -p "$d2/allostat/templates"
  rc=0; { [ "$impl" = npm ] && run_npm "$d2" >/dev/null 2>&1; } || rc=$?
  { [ "$impl" = pip ] && { run_pip "$d2" >/dev/null 2>&1 || rc=$?; }; } || true
  [ "$rc" -eq 2 ] && ok "$impl: detects tool-repo collision (exit 2)" || bad "$impl: collision guard (exit $rc)"
done

# --- Case 4: usage errors (exit 1).
say "case 4: usage"
rc=0; node "$NPM_PKG/bin/allostat.js" init "$WORK/nope" >/dev/null 2>&1 || rc=$?
[ "$rc" -eq 1 ] && ok "npm: bad target exits 1" || bad "npm: bad target (exit $rc)"
rc=0; PYTHONPATH="$PIP_PKG/src" python3 -m allostat.cli init "$WORK/nope" >/dev/null 2>&1 || rc=$?
[ "$rc" -eq 1 ] && ok "pip: bad target exits 1" || bad "pip: bad target (exit $rc)"

say ""
say "passed: $PASS  failed: $FAIL"
[ "$FAIL" -eq 0 ]
