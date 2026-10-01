---
name: approve-plan
description: Use after a plan is written (superpowers:writing-plans or any implementation plan) and before any implementation starts — gets explicit human approval of the plan and its execution mode (easy / complex). Implementation without approval is not allowed.
---

# Approve Plan

A plan is not approved until the human says so explicitly in this conversation.

0. Make sure the plan has these two lines directly under its `# Title`:
   ```
   **Status:** Draft
   **Mode:** easy | complex
   ```
   Add them if missing; set Status back to `Draft` whenever the plan changes.
   Recommend a mode: **easy** for mechanical, low-risk work the human is happy to delegate (content updates, dependency swaps, renames); **complex** for new features, new integrations, design-heavy or risky work. When unsure, recommend complex.
1. Link the plan file.
2. Summarize it in at most 5 bullets: goal, tasks (count + one line each if ≤ 6), files touched, commits planned, risks/open questions.
3. Ask: **"Approve this plan? Recommended mode: <mode> — <one-line reason>. (yes / yes, <other mode> / changes: …)"** and stop. Do not start any task, edit any file, or invoke an execution skill in the same turn.
4. On changes: update the plan, then repeat from step 1.
5. Only an explicit approval ("yes", "approved", "go") counts. Silence, questions, or "looks interesting" do not. A mode named in the reply overrides the recommendation.

## On approval

Plan approval is also approval to commit the plan and every task commit of this run — do it right away, without asking again:

1. Set `**Status:** Approved (YYYY-MM-DD)` with today's date and `**Mode:**` to the approved mode.
2. Stage only the plan file, as its own command: `git add docs/superpowers/plans/<file>.md` (prefix `cd <repo> && ` if needed).
3. Commit as a separate, bare command: `git commit -m "chore: add <feature> implementation plan"` (prefix `cd <repo> && ` if needed). Single line, no trailers, no `-a`, nothing chained after it. If anything other than the plan file is staged, don't commit — tell the human.
4. Start the run: `git config claude.planRun "docs/superpowers/plans/<file>.md|$(date +%s)"` in that repo. This lets the run's commits and execution skill through the permission gates for 12 hours.
5. Invoke the mode's skill: `easy-flow` or `complex-flow`.

Approval covers this plan version only — if the plan changes materially during implementation, set Status back to `Draft`, run `git config --unset claude.planRun`, stop and ask again.
