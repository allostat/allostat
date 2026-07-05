# Environment

Cross-domain layer 3 — your machine, tools, and working setup: the inventory that applies regardless of which project or mode you're in. Project-scope layer 2 files point here so Claude knows your environment without you re-explaining it each session.

Incomplete by design: the absence of a tool here means "not yet inventoried," not "not installed." When Claude needs to know whether something is available and it's not listed, it should ask rather than assume.

**Last updated:** [YYYY-MM-DD]

---

<!-- SECTION:BEGIN system -->
## System

- **Hardware:** [YOUR-HARDWARE]
- **OS:** [YOUR-OS-AND-VERSION]
- **Shell:** [YOUR-SHELL]
- **Package manager:** [YOUR-PACKAGE-MANAGER]

<!-- SECTION:END system -->

<!-- SECTION:BEGIN tools -->
## Languages & runtimes

*Languages and runtime versions you work with.*

- [LANGUAGE — VERSION / NOTES]

## CLI tools

*Command-line tools Claude can assume are available, with any auth or scope notes.*

- [TOOL — WHAT IT'S FOR / AUTH NOTES]

## Editors & clients

*Where you work with Claude, and how each is configured.*

- [EDITOR-OR-CLIENT — CONFIG NOTES]

<!-- SECTION:END tools -->

<!-- SECTION:BEGIN working_preferences -->
## Working preferences for command-line interactions

*How you like commands delivered. The clipboard pipe is the one Claude reuses constantly — set it to your OS.*

- **Clipboard pipe:** `[YOUR-CLIPBOARD-PIPE]`
  <!-- macOS: { ... } 2>&1 | tee >(pbcopy) · Linux: tee >(xclip -selection clipboard) · Windows (Git Bash): tee /dev/clipboard -->
- [ANY OTHER COMMAND-LINE PREFERENCES]

<!-- SECTION:END working_preferences -->
