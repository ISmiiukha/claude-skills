---
name: complex-flow
description: Use to execute a plan approved with **Mode:** complex (invoked by approve-plan) — runs superpowers:subagent-driven-development with human checkpoints before every task, on every review's findings, and on the final branch review.
---

# Complex Flow

The human controls each step. These checkpoints are the human's explicit instruction and override
subagent-driven-development's "continuous execution / do not pause" rule. Everything else in that
skill (ledger, implementer and reviewer prompts, model selection) applies as written.

1. Check that `git config --get claude.planRun` is set in the repo. If not, the plan wasn't approved — stop and use `approve-plan`.
2. Invoke `superpowers:subagent-driven-development`, adding these stops:

**Before each task** — show a brief and stop:
```
Task N/M: <name>
Goal: <one line>
Files: <list>
Approach: <2-3 lines; note anything you'd decide differently from the plan>
Start? (yes / change: …)
```
Dispatch the implementer only after a yes. Apply requested changes to the brief (and to the plan if material — then Status back to `Draft` and re-approve).

**After each task review** — show the findings and stop:
```
Review of Task N — <verdict>
1. [Critical|Important|Minor] <file:line> — <finding> → suggest: fix | skip (<why>)
2. …
Reply e.g. "fix 1, 3; skip 2" or "all as suggested".
```
Fix only what the human chose. No findings → say so in one line and show the next task's brief.

**Final branch review** — same format and same rule.

3. Commits: task and fix commits need no extra approval (covered by the approved run). Before the last commit: type check (global rule).
4. Finish: `git config --unset claude.planRun`. Set the plan's status to `**Status:** Done (YYYY-MM-DD)` and include it in the last commit. Report: what was done, the commits, type check result.
