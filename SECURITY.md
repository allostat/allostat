# Security

Allostat ships files, not a service. Nothing runs in the background and there is no server to attack. Two surfaces are worth reporting on:

1. **The installers.** `init.sh`, `npx allostat`, and `pip install allostat` run on your machine and write into a directory you name.
2. **The templates they place.** Those files are instructions an AI reads and acts on inside your project, so a flaw in them can become an action taken on your behalf.

## The bar I'm aiming at

Allostat targets **[OpenSSF OSPS Baseline Level 1](https://baseline.openssf.org/)** — the entry tier for open source projects. Its security-policy requirement (OSPS-VM-02) is that the documentation names a security contact; the OpenSSF Scorecard `Security-Policy` check is the automated form of the same question. Level 1 is the honest bar for a pre-1.0 project with one maintainer; the higher tiers assume a team and a user base this doesn't have yet.

I'm naming it so you can hold me to it. If something here falls short of that bar, tell me — that counts as a report. So does arguing the bar is the wrong one for a tool that writes instruction files into your project.

## Reporting a vulnerability

Use GitHub's private reporting: **[Report a vulnerability](https://github.com/allostat/allostat/security/advisories/new)**. It opens a private thread with the maintainer — not an Issue, and not visible to anyone else. Public Issues stay public forever, so don't file anything exploitable there.

No GitHub account, or the form won't cooperate? Email **colby.kauk+security@gmail.com**. Either route stays private.

Useful to include: what you ran, what happened, and what someone could do with it. A rough reproduction beats a polished writeup.

This is a pre-1.0 project with one maintainer. Expect a first reply within a few days rather than within hours. You'll hear back either way, including when the answer is "working as intended" and why.

## In scope

- **The installers** — arbitrary code execution, writing outside the target directory, the existing-`allostat/` collision guard failing open, or the template fetch falling back to something it shouldn't.
- **Template sourcing** — all three installers fetch `main` as a tarball at install time (npm and pip fall back to a copy bundled at publish time; `init.sh` halts instead). Anything that lets a third party change what lands on disk.
- **The published packages** — integrity of `allostat` on npm and PyPI, including typosquats you come across.
- **Template content** — a shipped file that steers an assistant toward an action a reasonable user wouldn't sanction: reaching outside the project, writing where it shouldn't, or pulling credentials into a context file that then gets committed.

## Out of scope

- **The assistant's output.** It's generated and non-deterministic (see the README's disclaimer). A wrong or unhelpful answer isn't a vulnerability.
- **Flaws in Claude, GitHub, npm, or PyPI themselves.** Report those to them.
- **Anything that already assumes write access** to your machine or your repository.

## Supported versions

Pre-1.0. Fixes go to the latest release only — currently the 0.2.x line.

## Notes for anyone installing

- `init.sh` is short and readable. If piping it to a shell bothers you, read it first, or clone the repo and run it locally — both paths are supported and place the same files.
- `--offline` (or `ALLOSTAT_OFFLINE=1`) makes the npm and pip installers use their bundled templates instead of fetching.
- The `allostat/` files are plain text in your repository, and they go wherever your repository goes. Keep credentials out of them — point at where a secret lives rather than pasting it in.
