#!/usr/bin/env bash
# Opens a file in neovide for commit message editing.
# ZZ and :wq both create /tmp/commit_saved (sentinel = user confirmed).
# :q! skips the write, leaving no sentinel (= user cancelled).
set -euo pipefail

FILE=/tmp/commit_msg.txt
SENTINEL=/tmp/commit_saved

if ! command -v neovide &>/dev/null; then
  echo "error: neovide not found in PATH" >&2
  exit 2
fi

rm -f "$SENTINEL"
# --cmd runs before the file loads (needed for mappings/autocmds to be in place from the start).
# -c runs after the file loads (needed for set filetype= to stick).
# ZZ is remapped to :wq so it always writes even when the buffer is unmodified
# (default ZZ = :x, which skips the write if nothing changed, defeating the sentinel).
# BufWritePost creates the sentinel file on any write; its absence means :q! was used.
neovide "$FILE" -- --cmd 'nnoremap ZZ :wq<CR> | au BufWritePost * call writefile(["saved"], "/tmp/commit_saved")' -c 'set filetype=gitcommit'

if [ -f "$SENTINEL" ]; then
  exit 0  # confirmed
else
  exit 1  # cancelled
fi
