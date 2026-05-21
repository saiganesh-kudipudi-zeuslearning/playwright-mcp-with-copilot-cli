#!/bin/bash

set -e

INPUT_PROMPT="$1"
PROMPT_FILE="prompts/build-todo.txt"

if [ -n "$INPUT_PROMPT" ]; then
  PROMPT="$INPUT_PROMPT"
else
  if [ ! -f "$PROMPT_FILE" ]; then
    echo "Prompt file not found: $PROMPT_FILE"
    exit 1
  fi

  PROMPT=$(cat "$PROMPT_FILE")
fi

echo "Resolved Prompt:"
echo "$PROMPT"

{
  echo "PROMPT<<EOF"
  echo "$PROMPT"
  echo "EOF"
} >> "$GITHUB_ENV"