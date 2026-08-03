# [PROJECT-NAME] — Environment (project-runtime)

Optional project-scope layer 3 — environment context specific to *this* project's runtime, as opposed to your machine-wide setup (which lives in your user-scope `environment.md`). Things like project-specific service URLs, ports, env-var names, tool versions pinned for this repo, or setup steps unique to running this project.

> **Never put secrets here.** Env-var *names*, ports, and URLs are fine; actual keys, tokens, passwords, and credentials are not — these files are meant to be committed. Point at where a secret lives (a `.env` file, a secrets manager), never paste its value. (Applies to every `allostatik/` file, but the risk is highest here.)

Develop it only if the project has runtime specifics worth recording — many projects won't need it. Point at it from `project-instructions.md`'s *Known references* so Claude pulls it when relevant.

**Last updated:** [YYYY-MM-DD]

<!-- Light — prose or bullets. Example:
- Local dev: npm run dev serves on port 5173; expects .env.local with API_BASE_URL.
- Pinned tooling: Node 20.x (.nvmrc); don't bump without a decision row.
-->
