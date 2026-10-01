# claude-skills

My personal Claude Code plugin marketplace (`my-skills`). Each plugin bundles skills and/or
hooks; the marketplace makes them installable on any machine from this GitHub repo.

## Layout

```
.claude-plugin/marketplace.json        # marketplace name + list of plugins
plugins/<plugin>/
  .claude-plugin/plugin.json           # name, version, description
  skills/<skill>/SKILL.md              # one folder per skill
  hooks/hooks.json                     # optional; hooks active while the plugin is enabled
```

## Plugins

- **plan-approval** — human approval gate between a superpowers plan and its implementation.
  - `approve-plan` skill: adds `**Status:** Draft` to the plan, summarizes it, waits for an
    explicit "yes", then sets `**Status:** Approved (YYYY-MM-DD)` and commits the plan file
    (`chore: add <feature> implementation plan`).
  - Hook: forces a permission prompt before `superpowers:executing-plans` or
    `superpowers:subagent-driven-development` starts.
  - Works with the global commit gate in `~/.claude/hooks/commit-gate.sh` (not part of this
    repo), which lets a plan-only commit through without a prompt.

## Install / update

```
/plugin marketplace add ISmiiukha/claude-skills     # once per machine
/plugin install plan-approval@my-skills
/plugin marketplace update my-skills                    # pull new versions
```

Local testing without pushing: `/plugin marketplace add ~/Documents/code/claude-skills`.

## Adding things

- **New skill in an existing plugin:** `plugins/<plugin>/skills/<name>/SKILL.md` with
  frontmatter `name` + `description`. The description decides when the skill triggers — start
  it with "Use when …" and name the concrete situation.
- **New plugin:** create `plugins/<name>/.claude-plugin/plugin.json`, then add an entry to
  `plugins` in `.claude-plugin/marketplace.json` (`"source": "./plugins/<name>"`).
- **Releasing a change:** bump `version` in the plugin's `plugin.json` — installed copies are
  cached by version and won't update otherwise.

## Conventions

- Keep skills short and imperative; one job per skill.
- Hooks: plain shell + `jq`, no other dependencies. A PreToolUse hook prints the
  `hookSpecificOutput` JSON to decide, or nothing to stay out of the way. Pipe-test every hook
  before committing:
  `jq -nc '{tool_name:"Skill",tool_input:{skill:"superpowers:executing-plans"}}' | <hook command>`
- No build step, no type checker — skip the type-check step before commits.
- Commits follow the global rules: `type: message` (`feat` / `fix` / `chore`), one line, my
  approval required.
