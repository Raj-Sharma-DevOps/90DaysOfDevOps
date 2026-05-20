# Day 46 – Reusable Workflows and Composite Actions

# Task 1: Reusable Workflow — Build & Test

Created `.github/workflows/reusable-build-test.yml` with `workflow_call` trigger, inputs for `python_version` and `run_tests`, and output `test_result`.

---

# Task 2: Reusable Workflow — Docker Build & Push

Created `.github/workflows/reusable-docker.yml` with inputs `image_name` and `tag`, secrets for Docker Hub, output `image_url`.

---

# Task 3: Call Reusable Workflows

```yaml
jobs:
  test:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: "3.12"
      run_tests: true

  docker:
    needs: test
    uses: ./.github/workflows/reusable-docker.yml
    with:
      image_name: ${{ secrets.DOCKER_USERNAME }}/task-manager-api
      tag: latest
    secrets:
      docker_username: ${{ secrets.DOCKER_USERNAME }}
      docker_token: ${{ secrets.DOCKER_TOKEN }}
```

---

# Task 4: Composite Action

```yaml
# .github/actions/setup-app/action.yml
name: Setup App
description: Install Python and dependencies
runs:
  using: composite
  steps:
    - uses: actions/setup-python@v5
      with:
        python-version: "3.12"
    - run: pip install -r requirements.txt
      shell: bash
```

Use in workflow: `uses: ./.github/actions/setup-app`

---

# Task 5: When to Use Each

| Pattern | Use When |
|---|---|
| Reusable workflow | Full pipeline stages shared across repos |
| Composite action | Reusable step sequences within a job |

---

# Final Summary

Reusable workflows eliminate duplication across repos. Composite actions bundle steps into reusable units within a single repo.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
