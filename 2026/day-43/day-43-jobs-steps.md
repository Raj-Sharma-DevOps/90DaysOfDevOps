# Day 43 – Jobs, Steps, Env Vars & Conditionals

# Task 1: Multi-Job Workflow

## .github/workflows/multi-job.yml

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building the app"

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running tests"

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying"
```

Actions tab shows dependency chain: build → test → deploy.

---

# Task 2: Environment Variables

```yaml
env:
  APP_NAME: myapp

jobs:
  deploy:
    env:
      ENVIRONMENT: staging
    steps:
      - name: Print all vars
        env:
          VERSION: "1.0.0"
        run: |
          echo "App: $APP_NAME"
          echo "Env: $ENVIRONMENT"
          echo "Version: $VERSION"
          echo "SHA: ${{ github.sha }}"
          echo "Actor: ${{ github.actor }}"
```

Three levels: workflow → job → step. GitHub context variables available via `${{ }}`.

---

# Task 3: Job Outputs

```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    outputs:
      build_date: ${{ steps.date.outputs.today }}
    steps:
      - id: date
        run: echo "today=$(date +%Y-%m-%d)" >> $GITHUB_OUTPUT

  report:
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - run: echo "Build date was ${{ needs.setup.outputs.build_date }}"
```

Outputs pass data between jobs — e.g., version number from build job to deploy job.

---

# Task 4: Conditionals

```yaml
      - name: Main only step
        if: github.ref == 'refs/heads/main'
        run: echo "Running on main branch"

      - name: On failure
        if: failure()
        run: echo "Previous step failed"

      - name: Continue on error
        continue-on-error: true
        run: exit 1
```

| Condition | When It Runs |
|---|---|
| `if: github.ref == 'refs/heads/main'` | Only on main branch |
| `if: failure()` | When a previous step failed |
| `continue-on-error: true` | Step fails but job continues |

---

# Final Summary

Multi-job workflows with dependencies, environment variables at three levels, job outputs for data passing, and conditionals for flow control.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
