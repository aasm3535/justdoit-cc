# justdoit-cc

> Port of [justdoit](https://github.com/serejaris/justdoit) by [Ris](https://t.me/ris_ai) for **Claude Code**.

Turns any non-trivial task into a structured execution pack (`plans.md`, `status.md`, `test-plan.md`) before running anything. Plan first, execute second.

![just do it](https://raw.githubusercontent.com/serejaris/justdoit/main/assets/justdoit.gif)

## What it does

When you run `/justdoit <task>` in Claude Code, it will:

1. Analyze the repo and task
2. Create three durable files:
   - **plans.md** — dependency-ordered milestones with validation commands
   - **status.md** — live execution log, resumable by any future session
   - **test-plan.md** — validation gates tied to actual milestones
3. Propose an execution plan and wait for your confirmation
4. Execute: implement → validate → fix → mark done → next milestone

## Install

### One-liner (macOS / Linux / WSL)

```bash
curl -fsSL https://raw.githubusercontent.com/aasm3535/justdoit-cc/main/install.sh | bash
```

### PowerShell (Windows)

```powershell
irm https://raw.githubusercontent.com/aasm3535/justdoit-cc/main/install.ps1 | iex
```

### Manual

Copy `commands/justdoit.md` to your Claude Code commands directory:

```bash
mkdir -p ~/.claude/commands
cp commands/justdoit.md ~/.claude/commands/
```

## Usage

In any repo with Claude Code:

```
/justdoit add OAuth authentication
/justdoit refactor the payment module
/justdoit implement the PRD from docs/prd.md
```

Or just `/justdoit` with no arguments — Claude will ask what you want to do.

## How it works

The skill follows a 9-step workflow:

1. **Find target files** — uses repo conventions or defaults to `docs/`
2. **Normalize input** — extracts scope, goals, constraints, risks
3. **Execution analysis** — short preflight: decomposition, risks, open decisions
4. **Plan file** — milestones ordered by dependency, each with validation commands
5. **Status file** — current state, audit log, smoke checklist
6. **Test plan** — test levels, negative cases, acceptance gates
7. **Smart merge** — preserves history when updating existing files
8. **Execution proposal** — product-level summary, not a prompt dump
9. **Wait for confirmation** — never starts without your OK

### Key principles

- **Repo-aware**: reads the project before planning
- **Durable files**: plans live in files, not chat memory — fully resumable
- **Validation-first**: every milestone has concrete checks
- **Repair-before-continue**: fix failures before moving on
- **Explicit assumptions**: nothing hidden in milestone prose

## Credits

Based on [justdoit](https://github.com/serejaris/justdoit) by [Ris](https://t.me/ris_ai). Original skill built for OpenAI Codex, this is a port for Claude Code.

## License

MIT — see [LICENSE](LICENSE).
