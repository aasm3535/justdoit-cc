# justdoit

Convert a task into a short execution analysis plus three durable repo files: a plan file (source of truth), a status file (live execution log), and a test plan (validation and release gates).

Use dependency-safe milestones, validation-first execution, repair-before-continue, resumability, explicit assumptions, and a clean handoff into the next execution run.

## Invocation Policy

- Treat this as the default mode for any non-trivial task in a repo.
- Use for product work, coding, PRD decomposition, repo changes, or execution planning.
- Skip only for one-line factual answers, pure brainstorming, or trivial edits.

## Workflow

### 1. Determine target files
- Prefer the repository's current convention.
- If plan/status/test-plan files already exist, update them in place.
- If the user explicitly names files or paths, follow that exactly.
- Otherwise default to `docs/plans.md`, `docs/status.md`, and `docs/test-plan.md`.

### 2. Normalize the input
- Extract scope, goals, constraints, repo context, validation commands, dependencies, risks, and done definition.
- If the input is already a PRD, treat it as the source of truth.
- If the input is rough or partial, make the smallest reasonable assumptions and record them explicitly.

### 3. Write a short execution analysis before drafting files
- State how the task was decomposed.
- Call out missing context, risky assumptions, and open decisions.
- Explain milestone ordering and validation strategy.
- Keep it short and operational: preflight analysis, not an essay.

### 4. Build the plan file
Use this skeleton:

```md
# Plans

## Source
- Task: <one-line task statement>
- Canonical input: <PRD / issue / user request / note>
- Repo context: <repo or package area>
- Last updated: <YYYY-MM-DD>

## Assumptions
- <explicit assumption>

## Validation Assumptions
- <only if real repo commands are missing>

## Milestone Order
| ID | Title | Depends on | Status |
| --- | --- | --- | --- |
| M1 | <title> | - | [ ] |
| M2 | <title> | M1 | [ ] |

## M1. <Milestone title> `[ ]`
### Goal
- <what becomes true after this milestone>

### Tasks
- [ ] <task 1>
- [ ] <task 2>

### Definition of Done
- <observable result>

### Validation
```sh
<command 1>
<command 2>
```

### Known Risks
- <risk>

### Stop-and-Fix Rule
- If validation fails, fix the failure before moving to the next milestone.
```

Rules:
- Make milestones small enough to finish in one focused execution loop.
- Order milestones by dependency, not by narrative.
- For each milestone include: goal, tasks, definition of done, validation commands, known risks, explicit status, and a stop-and-fix rule.
- Prefer real repo commands. If commands are missing, propose defaults and mark them as assumptions.
- Do not create milestones that end with vague "investigate more" work unless discovery is the actual task.

### 5. Build the status file
Use this skeleton:

```md
# Status

## Snapshot
- Current phase: <phase or milestone>
- Plan file: <path>
- Status: <green / yellow / red>
- Last updated: <YYYY-MM-DD>

## Done
- <completed item>

## In Progress
- <current work item or `none`>

## Next
- <exact next milestone / task>

## Decisions Made
- <decision> - <reason>

## Assumptions In Force
- <assumption>

## Commands
```sh
<smoke or validation command>
```

## Current Blockers
- None

## Audit Log
| Date | Milestone | Files | Commands | Result | Next |
| --- | --- | --- | --- | --- | --- |
| <YYYY-MM-DD> | <milestone> | <paths> | `<cmd>` | <pass/fail> | <next> |

## Smoke / Demo Checklist
- [ ] <core user path works>
- [ ] <startup/build path works>
- [ ] <primary regression checks run>
```

Rules:
- The first `Next` item must point to the first unfinished plan milestone.
- Seed the file so the next run can resume without reconstructing context from chat history.

### 6. Build the test plan file
Use this skeleton:

```md
# Test Plan

## Source
- Task: <one-line task statement>
- Plan file: <path>
- Status file: <path>
- Repo context: <repo or package area>
- Last updated: <YYYY-MM-DD>

## Validation Scope
- In scope: <behaviors, flows, components, APIs>
- Out of scope: <deferred or non-applicable areas>

## Environment / Fixtures
- Data fixtures: <seed data, mocks, sample inputs>
- External dependencies: <APIs, queues, services, browsers, devices>
- Setup assumptions: <env vars, local services, accounts>

## Test Levels

### Unit
- <what must be covered>

### Integration
- <critical integrations or contracts>

### End-to-End / Smoke
- <core user journeys or CLI/API flows>

## Negative / Edge Cases
- <failure mode>
- <boundary or malformed input>

## Acceptance Gates
- [ ] `lint`
- [ ] `typecheck`
- [ ] `test`
- [ ] `build`
- [ ] <repo-specific acceptance command>

## Release / Demo Readiness
- [ ] Core scenario works end to end
- [ ] Primary regression checks are green
- [ ] No blocker-level known issue remains

## Command Matrix
```sh
<command 1>
<command 2>
```

## Open Risks
- <known validation gap>

## Deferred Coverage
- <follow-up test work not required for the current slice>
```

Rules:
- Tie test coverage to actual milestones and behavior changes.
- Prefer runnable checks over vague test intentions.
- Separate smoke checks from deeper regression coverage.
- Make release and demo gates explicit.

### 7. Merge carefully when files already exist
- Preserve completed items and audit history.
- Preserve useful existing test coverage notes and release gates.
- Update only affected milestones and test sections when scope changes.
- If the old structure is unusable, replace it once and record the migration in `status.md`.

### 8. Finish with a short execution proposal
- Briefly state what will start first, what execution loop will be used, and what would stop the run.
- Reference the test plan when describing validation.
- Mirror the language of the user's prompt. Do not switch to English unless the task was in English.
- Speak at the product / delivery level first. Technical details only if they affect scope, risk, or validation.
- End by asking for confirmation to start execution.

### 9. Wait for confirmation
- Do not start execution without explicit user approval.

## Output Format

When replying in chat after writing files:

1. **Short product-level summary** (2-4 lines): what is ready, what outcome the plan delivers, biggest risk if any.
2. **File paths**: list plan, status, and test-plan paths.
3. **Ready to execute** (3-5 bullets):
   - What starts first
   - Execution cycle: implement -> validate -> fix -> mark done -> continue
   - What validations will be used
   - What would stop the run
4. **Confirmation**: ask one short question like "Ready to start?" or match the user's language.

Do not paste full file contents into chat unless the user explicitly asks.

## Writing Rules

- Keep the plan file as the source of truth.
- Use inspectable statuses: `[ ]`, `[~]`, `[x]`.
- Make every validation command copy-pasteable.
- Keep assumptions in a dedicated section; never hide them inside milestone prose.
- Prefer tight bullets and tables over narrative paragraphs.
- Keep diffs scoped when updating existing files.
- The test plan must be specific to the repo and task, not a generic QA checklist.

## Missing Context Rules

- If repo validation commands are unknown, add a `Validation assumptions` block with provisional defaults (`lint`, `typecheck`, `test`, `build`).
- If milestone order depends on a missing product decision, ask the user only for that decision.
- If the task is too broad, split into phases — fully detail phase 1, keep later phases coarser.

## Task input

$ARGUMENTS
