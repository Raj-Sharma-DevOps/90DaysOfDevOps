# Day 41 – Triggers & Matrix Builds

# Task 1: Trigger on Pull Request

## .github/workflows/pr-check.yml

```yaml
name: PR Check

on:
  pull_request:
    branches: [main]
    types: [opened, synchronize, reopened]

jobs:
  pr-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "PR check running for branch ${{ github.head_ref }}"
```

---

## Test

Created branch `feature/day-41`, pushed commit, opened PR → workflow appeared on PR checks page.

---

# Task 2: Scheduled Trigger

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Every day at midnight UTC
```

**Every Monday at 9 AM UTC:** `'0 9 * * 1'`

---

# Task 3: Manual Trigger

## .github/workflows/manual.yml

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Target environment"
        required: true
        default: staging
        type: choice
        options: [staging, production]
```

Triggered manually from Actions tab → input printed in logs.

---

# Task 4: Matrix Builds

## .github/workflows/matrix.yml

```yaml
strategy:
  matrix:
    python-version: ["3.10", "3.11", "3.12"]
```

3 Python versions run in parallel. Extended with 2 OS → 6 total jobs (3 × 2).

---

# Task 5: Exclude & Fail-Fast

```yaml
strategy:
  fail-fast: false
  matrix:
    python-version: ["3.10", "3.11", "3.12"]
    os: [ubuntu-latest, windows-latest]
    exclude:
      - python-version: "3.10"
        os: windows-latest
```

| Setting | Behavior |
|---|---|
| `fail-fast: true` (default) | Cancels all matrix jobs when one fails |
| `fail-fast: false` | Other jobs continue even if one fails |

---

# Final Summary

Learned push, PR, schedule, and manual triggers. Matrix builds run the same job across multiple configurations in parallel.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
