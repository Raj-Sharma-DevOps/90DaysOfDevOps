# Day 47 – Advanced Triggers

# Task 1: PR Lifecycle

```yaml
on:
  pull_request:
    types: [opened, synchronize, reopened, closed]

steps:
  - run: echo "Event action is ${{ github.event.action }}"
  - run: echo "PR title ${{ github.event.pull_request.title }}"
  - run: echo "Author ${{ github.event.pull_request.user.login }}"
  - name: Merged only
    if: github.event.pull_request.merged == true
    run: echo "PR was merged!"
```

---

# Task 2: PR Validation

Branch name check fails if branch doesn't match `feature/*`, `fix/*`, or `docs/*`.

File size check fails if any file exceeds 1 MB.

---

# Task 3: Cron Schedules

```yaml
on:
  schedule:
    - cron: '30 2 * * 1'    # Monday 2:30 AM UTC
    - cron: '0 */6 * * *'   # Every 6 hours
  workflow_dispatch:
```

| Schedule | Cron |
|---|---|
| Weekdays 9 AM IST (3:30 UTC) | `'30 3 * * 1-5'` |
| First of month midnight | `'0 0 1 * *'` |

GitHub may delay/skip scheduled workflows on inactive repos.

---

# Task 4: workflow_run Chaining

```yaml
on:
  workflow_run:
    workflows: ["Main Pipeline"]
    types: [completed]
```

Triggers a downstream workflow when another completes.

---

# Final Summary

PR lifecycle events, cron schedules, workflow chaining, and validation gates for production-grade pipelines.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
