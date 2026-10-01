---
name: approve-plan
description: Use after a plan is written (superpowers:writing-plans or any implementation plan) and before any implementation starts — gets explicit human approval of the plan. Implementation without approval is not allowed.
---

# Approve Plan

A plan is not approved until the human says so explicitly in this conversation.

0. Make sure the plan has a status line directly under its `# Title`: `**Status:** Draft`. Add it if missing; set it back to `Draft` whenever the plan changes.
1. Link the plan file.
2. Summarize it in at most 5 bullets: goal, tasks (count + one line each if ≤ 6), files touched, commits planned, risks/open questions.
3. Ask: **"Approve this plan? (yes / changes: …)"** and stop. Do not start any task, edit any file, or invoke an execution skill in the same turn.
4. On changes: update the plan, then repeat from step 1.
5. Only an explicit approval ("yes", "approved", "go") counts. Silence, questions, or "looks interesting" do not.

## On approval: commit the plan

Plan approval is also approval to commit the plan file — commit it right away, without asking again:

0. Change the status line to `**Status:** Approved (YYYY-MM-DD)` with today's date.
1. Stage only the plan file, as its own command: `git add docs/superpowers/plans/<file>.md` (prefix `cd <repo> && ` if needed).
2. Commit as a separate, bare command: `git commit -m "chore: add <feature> implementation plan"` (prefix `cd <repo> && ` if needed). Single line, no trailers, no `-a`, nothing chained after it.
3. If anything other than the plan file is staged, don't commit — tell the human.

Then continue with the chosen execution skill. Approval covers this plan version only — if the plan changes materially during implementation, set the status back to `Draft`, stop and ask again.
