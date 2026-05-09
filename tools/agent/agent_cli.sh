#!/usr/bin/env bash
set -euo pipefail

# Simple CLI to invoke the ThesisAssistant agent for this repo.
# Usage:
#   ./tools/agent/agent_cli.sh "@thesisassistant PLAN-ONLY: Improve intro"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO_ROOT="$ROOT/.."
AGENT_SPEC="$REPO_ROOT/.opencode/agents/thesisassistant.md"

INPUT="$1"

if [[ "${INPUT,,}" != *@thesisassistant* ]]; then
  echo "Input must include @thesisassistant" >&2
  exit 1
fi

PLAN_ONLY=false
if echo "$INPUT" | grep -qi "PLAN-ONLY"; then
  PLAN_ONLY=true
fi

echo "[thesisassistant] Loading agent spec: $AGENT_SPEC"
if [[ ! -f "$AGENT_SPEC" ]]; then
  echo "Agent spec not found: $AGENT_SPEC" >&2
  exit 1
fi

echo "[thesisassistant] Scanning content/ for context..."
rg --hidden --no-ignore --no-messages "" "$REPO_ROOT/content" || true

echo "[thesisassistant] Building compact plan (targets, create/update, assumptions)"
# For now we generate a minimal plan stub by echoing the intent and targets
cat <<EOF
Plan:
- Intent: ${INPUT}
- Targets: (detected by scanning args) -- default: review all content/
- Assumptions: Uses Community-Network-Handbook as reference at /home/mj/Community-Network-Handbook (develop branch)
- Open questions: Which files specifically should be edited? Any style constraints beyond .opencode?

Approval required before proceeding. To run in non-PLAN mode re-run without PLAN-ONLY in the command.
EOF

if [[ "$PLAN_ONLY" == "true" ]]; then
  exit 0
fi

read -p "Approve and execute? (y/N) " yn
if [[ "${yn,,}" != "y" ]]; then
  echo "Aborting."; exit 0
fi

echo "[thesisassistant] Preparing branch and invoking LLM for edits (dry-run mode)"
BRANCH="thesisassistant/$(date +%Y%m%dT%H%M%S)/plan"
git checkout -b "$BRANCH"

# Placeholder: call LLM helper (not included). For now we create a TODO file.
TODO_FILE="$REPO_ROOT/.thesisassistant_todo.md"
cat > "$TODO_FILE" <<EOF
ThesisAssistant executed on: $(date --iso-8601=seconds)
Input: $INPUT
Branch: $BRANCH
This is a placeholder; integrate with your LLM of choice.
EOF

git add "$TODO_FILE"
git commit -m "chore(agent): scaffold edits from ThesisAssistant for input: ${INPUT}" || true

echo "Created branch $BRANCH and committed scaffolding. Run your preferred LLM helper to apply edits, then run latex/build.sh to verify." 

exit 0
