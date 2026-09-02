# Session Logs

Keep one append-only, branch-scoped Markdown log per working branch. Single-app branches use `YYYY-MM-DD-featurebranch.md`; direct work on `main` may use `main.md`. Derive the date from the branch reflog or first unique commit when possible, and replace `/` with `-` in the filename.

Update the current branch log after each completed GitHub Task and immediately before its commit. Preserve prior entries as durable history; corrections should be new entries rather than rewrites.

## Entry template

```md
## YYYY-MM-DDTHH:MM:SSZ

- **agent:** Codex or human name
- **branch:** `branch/name`
- **head:** pre-commit SHA
- **issue:** linked GitHub Goal or Task
- **summary:** outcome and important boundaries
- **validation:** exact commands and evidence
- **follow-ups:** deferred or blocked work, or `None`
```
