#!/bin/bash

set -e

# ── OTel config (confirmed env vars) ─────────────────────
export COPILOT_OTEL_FILE_EXPORTER_PATH="$GITHUB_WORKSPACE/copilot-traces.jsonl"
export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=true
# ─────────────────────────────────────────────────────────

echo "STEP 1 - Configure Model"

MODEL="gpt-4.1"

echo "Using model: $MODEL"

echo "STEP 2 - Ensure MCP Server Exists"

if copilot mcp list | grep -q "playwright-test"; then
  echo "MCP server already exists: playwright-test"
else
  copilot mcp add playwright-test --tools "*" -- npx playwright run-test-mcp-server
  echo "MCP server added: playwright-test"
fi

echo "STEP 3 - Resolve Prompt"

if [ -n "$PROMPT" ]; then
  echo "Using PROMPT from GitHub Actions input"
else
  PROMPT_FILE="prompts/build-todo.txt"
  if [ ! -f "$PROMPT_FILE" ]; then
    echo "Prompt file not found: $PROMPT_FILE"
    exit 1
  fi
  echo "Using PROMPT from file: $PROMPT_FILE"
  PROMPT=$(cat "$PROMPT_FILE")
fi
echo ""
echo "Resolved Prompt:"
echo "$PROMPT"

copilot \
  --model "$MODEL" \
  --agent playwright-bdd-generator \
  --prompt "$PROMPT" \
  --allow-all \
  --output-format text \
  --log-level all \
  --log-dir ~/copilot-logs \
  --no-ask-user

echo "STEP 4 - Git Status"

git status

echo "STEP 5 - Stage Changes"

git add .

if git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

echo ""
echo "STEP 6 - Generate AI Commit Message"

COMMIT_MESSAGE=$(copilot \
  -p "Generate a professional conventional commit message based on this development request:

$PROMPT

Rules:
- Return ONLY the commit message
- No explanations
- No quotes
- No markdown
- No co-author lines
- No AI references
- Max 72 characters
- Use conventional commits format

Examples:
feat: add playwright todo creation scenario
fix: resolve flaky login selector
chore: update github actions workflow" \
  --model "$MODEL" \
  --allow-tool='shell(git:*)' \
  --no-ask-user \
  --output-format text \
  -s)

COMMIT_MESSAGE=$(echo "$COMMIT_MESSAGE" \
  | tr '\n' ' ' \
  | xargs)

COMMIT_MESSAGE=$(echo "$COMMIT_MESSAGE" \
  | sed 's/Co-authored-by:.*//')

COMMIT_MESSAGE=${COMMIT_MESSAGE:0:80}

echo ""
echo "Generated Commit Message:"
echo "$COMMIT_MESSAGE"

echo ""
echo "STEP 7 - Review Staged Changes"

git --no-pager diff --cached

echo ""
echo "STEP 8 - Commit Changes"

git commit -m "$COMMIT_MESSAGE"

echo ""
echo "Changes committed successfully"

# Count how many spans were captured
wc -l copilot-traces.jsonl

# See only the LLM call spans (chat spans)
cat copilot-traces.jsonl | grep '"name":"chat"' | wc -l

# Pretty print one span to inspect the structure
cat copilot-traces.jsonl | grep '"name":"chat"' | head -1 | python3 -m json.tool