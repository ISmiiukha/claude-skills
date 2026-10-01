#!/bin/bash
# PreToolUse(Skill): force a permission prompt before a superpowers execution skill starts,
# unless an approved plan run is active in the session's repo (claude.planRun, < 12h old,
# set by the approve-plan skill after the human approved the plan).
input=$(cat)
jq -r '.tool_input.skill // empty' <<<"$input" | grep -qE '(^|:)(executing-plans|subagent-driven-development)$' || exit 0
dir=$(jq -r '.cwd // empty' <<<"$input")
run=$(git -C "${dir:-$PWD}" config --get claude.planRun 2>/dev/null)
started=${run##*|}
[[ "$started" =~ ^[0-9]+$ ]] && [ $(( $(date +%s) - started )) -lt 43200 ] && exit 0
echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"Plan implementation requires your approval"}}'
