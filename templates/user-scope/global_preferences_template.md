# Global Preferences — user scope (Layer 1)

Your identity layer: the preferences and working style that apply across *all*
your projects, deployed into your AI surface's account-level settings
(e.g. Claude Desktop → Profile → Custom Instructions).

Canonical template source: allostat/templates/user-scope/global_preferences_template.md
Paste destination: [YOUR-DEPLOYMENT-TARGET]   — e.g. Custom Instructions
Versioned copy:    [YOUR-STORAGE-LOCATION]    — where you keep this canonical copy
Last reviewed:     [YYYY-MM-DD], against [CLAUDE-MODEL]

---

## The minimal add — make Allostat projects recognizable

This is the only Layer-1 change Allostat itself needs. Add this block to your
account-level instructions so the AI recognizes an Allostat project when it
opens one:

> Some of my projects use a layered context system: canonical files (an
> `allostat/` folder, with a `CLAUDE.md` listing what to load) that are the
> source of truth. When a project has them: load them, treat them as
> authoritative, follow its `workflow.md` to keep them in sync (drift-check at
> start, update at close), and flag anything stale rather than following it. If
> a project doesn't have them, ignore this.

Keep this canonical copy in sync with what's deployed — the drift-check at
session start compares the two, so an edit here means a re-paste there.

---

## Your own preferences (optional)

Everything below is *yours*: cross-project working style you want the AI to
follow everywhere. It's optional — Allostat works with just the block above —
but this is where the identity layer earns its keep.

Keep it lean. Layer 1 is only what applies to *all* your work. Project-specific
rules live in that project's `allostat/project-instructions.md` (L2); machine
and tool details live in `allostat/knowledge/environment.md` (L3).

> The bullets below are **examples** showing the shape of a good preference —
> replace them with your own or delete them. Nothing here is active until you
> make it yours.

### Working philosophy — how you approach the work

<!-- Examples — replace or delete: -->
- *Bias toward the faster feedback loop: build, test, and refine in one session
  rather than planning exhaustively up front.*
- *Name the broken windows you notice — a stale comment, a workaround that
  should be a fix — even when we choose not to fix them now.*

### How I want you to work with me

<!-- Examples — replace or delete: -->
- *Teach as you go: explain the reasoning behind a recommendation, and fade the
  detail as I show I've got it.*
- *Push back when I'm wrong — don't be agreeable at the cost of being useful.*
- *Flag what I don't know I should know: common pitfalls, better-known patterns,
  best practices I'm missing.*

### Behaviors — concrete conventions

<!-- Examples — replace or delete: -->
- *When you give me a command whose output I'll paste back, wrap it so the
  output copies to my clipboard automatically.*
- *Batch related git steps (add + commit + push) into one command; split them
  when I need to check the output in between.*

### Context — who you are across projects

<!-- Examples — replace or delete: -->
- *Primary domains: [e.g. web development, construction safety].*
- *When the mode is ambiguous, ask which I mean rather than guessing.*

---

*Why so lean? Allostat treats Layer 1 as optional and minimal by default — the
recognition block is all the methodology needs. The design reasoning (layers,
the gate, why principles can change) lives in `concepts.md`.*
