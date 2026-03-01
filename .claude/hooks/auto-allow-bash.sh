#!/bin/bash
# PostToolUse hook: detect Bash commands not in the allow list
# and notify Claude to ask the user about adding them.

set -euo pipefail

SETTINGS_FILE="$HOME/.claude/settings.json"

# Read hook input from stdin
INPUT=$(cat)

# Extract the command that was executed
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
if [[ -z "$COMMAND" ]]; then
  exit 0
fi

# Extract the base command name (first word, ignoring env vars like FOO=bar)
BASE_CMD=""
for word in $COMMAND; do
  # Skip variable assignments (e.g., NODE_ENV=production)
  if [[ "$word" == *=* ]]; then
    continue
  fi
  BASE_CMD="$word"
  break
done

if [[ -z "$BASE_CMD" ]]; then
  exit 0
fi

# Skip commands that are managed by dedicated tools (not typically in allow list)
SKIP_CMDS=("cd" "echo" "printf" "true" "false" "test" "[" "[[" "exit" "return" "source" ".")
for skip in "${SKIP_CMDS[@]}"; do
  if [[ "$BASE_CMD" == "$skip" ]]; then
    exit 0
  fi
done

# Check if already in allow list with wildcard pattern
PATTERN="Bash(${BASE_CMD} *)"
PATTERN_EXACT="Bash(${BASE_CMD})"

if [[ ! -f "$SETTINGS_FILE" ]]; then
  exit 0
fi

ALLOW_LIST=$(jq -r '.permissions.allow // [] | .[]' "$SETTINGS_FILE" 2>/dev/null)

while IFS= read -r rule; do
  if [[ "$rule" == "$PATTERN" || "$rule" == "$PATTERN_EXACT" || "$rule" == "Bash(*)" ]]; then
    exit 0
  fi
done <<< "$ALLOW_LIST"

# Not in allow list — notify Claude
echo "[auto-allow] \"${BASE_CMD}\" コマンドは settings.json の許可リストにありません。ユーザーに Bash(${BASE_CMD} *) を追加するか確認してください。"
