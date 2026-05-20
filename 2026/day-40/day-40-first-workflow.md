# Day 40 – Your First GitHub Actions Workflow

# Task 1: Set Up

Created repo structure:

```text
github-actions-practice/
└── .github/
    └── workflows/
        └── hello.yml
```

---

# Task 2: Hello Workflow

## .github/workflows/hello.yml

```yaml
name: Hello GitHub Actions

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print greeting
        run: echo "Hello from GitHub Actions!"
```

---

## First Run

Pushed to GitHub → Actions tab → workflow ran green.

---

# Task 3: Understand the Anatomy

| Key | What It Does |
|---|---|
| `on:` | Defines triggers — when the workflow runs |
| `jobs:` | Container for all jobs in the workflow |
| `runs-on:` | Which runner OS to use (ubuntu-latest, windows-latest, etc.) |
| `steps:` | Ordered list of actions/commands within a job |
| `uses:` | References a pre-built action (e.g., actions/checkout@v4) |
| `run:` | Executes a shell command on the runner |
| `name:` | Human-readable label for a step (shows in the UI) |

---

# Task 4: Add More Steps

Added steps to print date/time, branch name, file listing, and runner OS:

```yaml
      - name: Print date and time
        run: date

      - name: Print branch name
        run: echo "Branch is ${{ github.ref_name }}"

      - name: List repo files
        run: ls -la

      - name: Print runner OS
        run: echo "Runner OS is ${{ runner.os }}"
```

---

# Task 5: Break It On Purpose

Added failing step:

```yaml
      - name: Intentional failure
        run: exit 1
```

---

## Observation

The pipeline turned **red** with a clear error on the failing step. Fixed by removing the step and pushing again — pipeline went green.

A failed pipeline shows which step failed, the error message, and logs for debugging.

---

# Final Summary

Today I wrote my first GitHub Actions workflow, watched it run in the cloud, and learned the basic anatomy: triggers, jobs, steps, and actions.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
