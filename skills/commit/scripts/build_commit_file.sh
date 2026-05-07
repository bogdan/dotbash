#!/usr/bin/env bash
# Writes a git-commit-v style file to /tmp/commit_msg.txt.
# Usage: build_commit_file.sh "<commit message>"
set -euo pipefail

MESSAGE="${1:?Usage: build_commit_file.sh <message>}"

{
  printf '%s\n' "$MESSAGE"
  printf '%s\n' "#"
  printf '%s\n' "# Lines starting with '#' will be ignored. An empty message aborts the commit."
  git status | sed 's/^/# /'
  printf '%s\n' "# ------------------------ >8 ------------------------"
  printf '%s\n' "# Do not modify or remove the line above."
  printf '%s\n' "# Everything below it will be ignored."
  git diff --staged
} > /tmp/commit_msg.txt
