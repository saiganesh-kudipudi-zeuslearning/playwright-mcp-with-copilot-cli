#!/bin/bash

set -e

MODEL="gpt-4.1"

if [ -z "$PROMPT" ]; then
  echo "ERROR: PROMPT variable is not set"
  exit 1
fi

RAW_BRANCH_NAME=$(copilot \
  -p "Generate a professional git branch name for this development request.

Development Request:
$PROMPT

Rules:
- Return ONLY the branch name
- Use kebab-case only
- No explanations
- No quotes
- No markdown
- Keep it concise
- Max 6 words
- Focus on feature intent, not implementation details

Examples:
bdd-login-flow
playwright-todo-tests
github-actions-ai-workflow
todo-delete-scenarios" \
  --model "$MODEL" \
  --allow-tool='shell(git:*)' \
  --no-ask-user \
  --output-format text)

BRANCH_NAME=$(echo "$RAW_BRANCH_NAME" \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/[^a-z0-9-]/-/g' \
  | sed 's/--*/-/g' \
  | sed 's/^-//' \
  | sed 's/-$//' \
  | cut -c1-50)

if [ -z "$BRANCH_NAME" ]; then
  echo "ERROR: Failed to generate branch name"
  exit 1
fi

TIMESTAMP=$(date +'%Y%m%d-%H%M%S')

BRANCH="ai-generated/${BRANCH_NAME}-${TIMESTAMP}"

echo "Using branch: $BRANCH"

git checkout -b "$BRANCH"

if [ -n "$GITHUB_ENV" ]; then
  echo "BRANCH_NAME=$BRANCH" >> "$GITHUB_ENV"
fi