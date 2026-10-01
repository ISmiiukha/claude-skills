# my-skills

Personal Claude Code plugin marketplace.

Install:

```
/plugin marketplace add ISmiiukha/claude-skills
/plugin install plan-approval@my-skills
```

## Plugins

### plan-approval

Human approval between a [superpowers](https://github.com/obra/superpowers) plan and its implementation, and two ways to run it:

| Mode | For | You control |
|------|-----|-------------|
| **easy** | CV update, swap lodash → remeda, mechanical changes | Plan approval only. Claude decides everything else and reports its rulings at the end. |
| **complex** | New features, integrations, risky work | Plan approval, each task before it starts, which review findings get fixed, the final review. |

Flow: plan written → `approve-plan` (status **Draft**, recommended mode) → you reply `yes` / `yes, complex` / `changes: …` → status **Approved**, plan committed → `easy-flow` or `complex-flow` → type check → status **Done**.

A hook asks for permission before any superpowers execution skill starts, unless a plan run was approved (tracked in `git config claude.planRun`, expires after 12h).
