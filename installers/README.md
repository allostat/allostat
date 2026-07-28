# installers/ — the npx and pip packages

Canonical **source** for the two published installers. Both are ports of `init.sh` with **fetch-first-with-fallback** template sourcing: at install time they fetch the current templates from GitHub main, and fall back to the copy **bundled at build time** if the fetch fails (offline, blocked, no system tar). Fresh when online, always works, and both paths place real files — the never-reconstruct rule holds everywhere. `--offline` / `ALLOSTAT_OFFLINE=1` skips the fetch.

- `npm/` — publishes as [`allostat` on npm](https://www.npmjs.com/package/allostat): `npx allostat init ./your-project`
- `pip/` — publishes as [`allostat` on PyPI](https://pypi.org/project/allostat/): `pip install allostat && allostat init ./your-project`

**Templates are not stored here** — `scripts/bundle-templates.sh` copies `templates/project-boilerplate/` into each package right before publishing. The canonical templates live in `templates/`; anything under `installers/npm/templates/` or `installers/pip/src/allostat/templates/` is a gitignored publish artifact. (DRY: one source, assembled copies.)

**Behavior parity is a tested invariant.** `scripts/test-installers.sh` runs init.sh, the npm bin, and the pip CLI against identical scratch projects (greenfield, existing, collision, tool-repo-collision) and diffs the resulting trees and exit codes. Run it after touching any of the three.

**Releasing:**

1. Bump `version` in `npm/package.json` and `pip/pyproject.toml` + `pip/src/allostat/__init__.py` (keep them in lockstep).
2. `scripts/bundle-templates.sh` (refreshes the bundled fallback from `templates/`)
3. `cd installers/npm && npm publish`
4. `cd installers/pip && python -m build && twine upload dist/*`

Online installs always get current main automatically; the bundled fallback advances only via republish — so republish after significant template changes to keep offline installs close. `init.sh` and the repo always carry current main.
