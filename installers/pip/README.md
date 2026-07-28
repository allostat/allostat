# allostat (installer)

Installer for **Allostat** — a folder of canonical context files plus session routines that keep the context your AI works from sharp, consistent, and current.

```
pip install allostat
allostat init /path/to/your-project
```

This places the real template files (bundled with this package) into your project and prints the next steps. It never overwrites an existing `allostat/` folder or `CLAUDE.md`. Filling the files happens in your first AI session — `workflow.md` walks you (and your AI) through it.

Full docs, design reasoning, and the no-Python install path: **https://github.com/allostat/allostat**

MIT.
