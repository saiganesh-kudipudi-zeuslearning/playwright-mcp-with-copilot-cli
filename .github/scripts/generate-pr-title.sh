#!/bin/bash

set -e

MODEL="gpt-4.1"

PR_TITLE=$(copilot \
  -p "Generate a professional GitHub pull request title for this development request.

Development Request:
$PROMPT

Rules:
- Return ONLY the PR title
- No explanations
- No quotes
- No markdown
- No prefixes like 'PR:' or 'Title:'
- Keep it concise and professional
- Max 10 words
- Focus on feature intent, not implementation details

Examples:
Add TodoMVC BDD scenarios
Implement AI-powered Playwright workflow
Add Playwright login flow automation
Create GitHub Actions AI generation pipeline" \
  --model "$MODEL" \
  --allow-tool='shell(git:*)' \
  --no-ask-user \
  --output-format text \
  -s)

PR_TITLE=$(echo "$PR_TITLE" \
  | tr '\n' ' ' \
  | xargs)

PR_TITLE=$(echo "$PR_TITLE" \
  | sed 's/^PR[: -]*//I')

PR_TITLE=${PR_TITLE:0:100}

echo "PR_TITLE=$PR_TITLE" >> "$GITHUB_ENV"

echo "Generated PR Title:"
echo "$PR_TITLE"