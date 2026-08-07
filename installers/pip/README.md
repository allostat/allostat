# allostatik (installer)

Installer for **Allostatik** — a folder of canonical context files plus session routines that keep the context your AI works from sharp, consistent, and current.

Navigate to your project's root folder, then use whichever toolchain you have:

```
npx allostatik init .
pip install allostatik && allostatik init .
curl -fsSL https://raw.githubusercontent.com/allostatik/allostatik/main/init.sh | sh -s -- .
```

All three place the same real template files into your project and print the next steps. They fetch the current templates from the repo at install time; the npm and pip packages also carry a bundled copy as an offline fallback. Nothing is overwritten — an existing `allostatik/` folder, `CLAUDE.md`, or `AGENTS.md` is left alone.

Filling the files happens in your first AI session — `workflow.md` walks you (and your AI) through it.

Full docs, design reasoning, and the by-hand install path: **https://github.com/allostatik/allostatik**

MIT.
