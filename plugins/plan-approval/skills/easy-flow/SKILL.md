---
name: easy-flow
description: Use to execute a plan approved with **Mode:** easy (invoked by approve-plan) — runs superpowers:subagent-driven-development end to end with no human checkpoints; Claude makes all rulings itself and reports at the end.
---

# Easy Flow

The human approved the plan and delegated every decision. Do not stop to ask.

1. Check that `git config --get claude.planRun` is set in the repo. If not, the plan wasn't approved — stop and use `approve-plan`.
2. Invoke `superpowers:subagent-driven-development` and follow it as written: continuous execution, rulings instead of stalls, task commits, task reviews, final branch review. Fix review findings yourself.
3. Keep a list of every ruling you made on your own (ambiguities, plan defects, skipped review findings) — one line each.
4. Before the last commit: type check (global rule). Fix failures before committing.
5. Finish: `git config --unset claude.planRun`. Set the plan's status to `**Status:** Done (YYYY-MM-DD)` and include it in the last commit.
6. Report once, briefly: what was done, the rulings list, the commits (`git log --oneline <base>..HEAD`), type check result.

**Upgrade, don't push through.** If the work turns out bigger or riskier than the plan said (new design decisions, unclear behavior, breaking changes), stop, unset `claude.planRun`, and propose switching to `complex-flow`. Nothing downgrades mid-run.
