---
name: commit
description: Generate a commit message, open it in neovide for editing, then commit after the editor closes.
disable-model-invocation: true
argument-hint: "[file...] [-- context]"
allowed-tools: Bash(git diff *) Bash(git status) Bash(git log *) Bash(git add *) Bash($HOME/.claude/skills/commit/scripts/open_editor.sh) Bash($HOME/.claude/skills/commit/scripts/build_commit_file.sh *) Bash($HOME/.claude/skills/commit/scripts/git_commit.sh) Read
---

Generate a commit message for the staged changes and let the user edit it before committing.

Arguments: `$ARGUMENTS`

## Interpreting arguments

Arguments are optional and free-form. Parse them as follows:

- **`.` or `all`**: run `git add -A` to stage everything before proceeding.
- **File paths** (tokens that look like paths, e.g. `app/models/user.rb`, `./config/*`): run `git add <path>` for each before proceeding.
- **Context/instructions** (everything else, e.g. "fixes #123" or "mention migration"): use as additional guidance when generating the commit message. Do not add it verbatim to the message.
- Both can appear together, e.g. `/commit app/models/user.rb fixes issue with login`.

If no arguments are given, work with whatever is already staged.

## Steps

1. If arguments contain file paths, stage them with `git add`.
2. Run `git diff --staged` and `git status` to understand what is staged.
3. If nothing is staged, tell the user and stop.
4. Generate a concise commit message (subject line only, imperative mood, ≤72 chars). Use recent `git log --oneline -5` to match the repo's style. Incorporate any context from the arguments.
5. Build `/tmp/commit_msg.txt` using the bundled script:
   ```
   ${CLAUDE_SKILL_DIR}/scripts/build_commit_file.sh "<message>"
   ```
   See `scripts/build_commit_file.sh` for the format (message + `#` comments + diff, `git commit -v` style).
6. Open the file in the editor using the bundled script (exits 0 = confirmed, exits 1 = cancelled):
   ```
   ${CLAUDE_SKILL_DIR}/scripts/open_editor.sh
   ```
   See `scripts/open_editor.sh` for details on how `:wq`/`ZZ` vs `:q!` are detected.
7. If the script exits 1, the user cancelled — abort and tell them no commit was made.
8. Otherwise run: `${CLAUDE_SKILL_DIR}/scripts/git_commit.sh`
   - Strips `#` comment lines and everything after the scissors line, then runs `git commit -F -`.

## Notes

- Do not add a "Co-Authored-By" trailer unless the user has added it themselves in the editor.
