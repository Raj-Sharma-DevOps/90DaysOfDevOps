# Day 39 – What is CI/CD?

# Task 1: The Problem

## What Can Go Wrong with Manual Deployments?

1. **Inconsistent environments** — code works on one developer's machine but fails in production
2. **No automated testing** — bugs reach users before anyone catches them
3. **Deployment bottlenecks** — only one person knows how to deploy
4. **Slow feedback loops** — issues discovered days or weeks after the code was written
5. **Human error** — wrong config, missed steps, accidental production deploys

---

## "It Works on My Machine"

This means the app runs locally but fails elsewhere because of differences in OS, dependencies, environment variables, or database state. CI/CD solves this by running the same build and test steps in a consistent environment every time.

---

## Manual Deploy Frequency

A team deploying manually might safely deploy **once a day** or **once a week**. With CI/CD, teams deploy **multiple times per day** because automation handles the repetitive, error-prone steps.

---

# Task 2: CI vs CD

## Continuous Integration (CI)

Developers merge code frequently into a shared branch. Each merge triggers automated **build and test** steps. CI catches integration bugs early — before they compound.

**Example:** Every push to `main` runs unit tests, linting, and a Docker build.

---

## Continuous Delivery (CD)

Every change that passes CI is automatically prepared for release to production. A human approves the final deploy, but everything up to that point is automated.

**Example:** After tests pass, the pipeline builds a Docker image and deploys to staging. A manager clicks "Approve" to promote to production.

---

## Continuous Deployment (CD)

Every change that passes all automated checks is **automatically deployed to production** with no manual gate. Used by teams with strong test coverage and feature flags.

**Example:** Netflix deploys thousands of times per day — each passing commit goes live automatically.

---

# Task 3: Pipeline Anatomy

| Component | What It Does |
|---|---|
| **Trigger** | Event that starts the pipeline (push, PR, schedule, manual) |
| **Stage** | Logical phase grouping jobs (build → test → deploy) |
| **Job** | Unit of work that runs on one runner (e.g., "run tests") |
| **Step** | Single command or action inside a job |
| **Runner** | Machine (GitHub-hosted or self-hosted) that executes jobs |
| **Artifact** | Output from a job (test reports, Docker images, binaries) |

---

# Task 4: Pipeline Diagram

```text
Developer pushes code to GitHub
         |
         v
    [TRIGGER: push to main]
         |
         v
    +-----------+
    |   BUILD   |  Install deps, compile, build Docker image
    +-----------+
         |
         v
    +-----------+
    |   TEST    |  Unit tests, integration tests, lint
    +-----------+
         |
         v
    +-----------+
    |  DEPLOY   |  Push image to registry, deploy to staging
    +-----------+
         |
         v
    Staging server running new version
```

---

# Task 5: Explore in the Wild

## Repo Explored: facebook/react

**Workflow:** `.github/workflows/compiler_types.yml`

| Question | Answer |
|---|---|
| What triggers it? | Push to specific paths + pull requests |
| How many jobs? | Multiple jobs for type checking |
| What does it do? | Runs Flow type checker on React compiler code |

---

## Observation

Even massive open-source projects rely on CI/CD for every change. The patterns are the same whether you're one developer or a team of hundreds.

---

# Final Summary

CI/CD is a **practice**, not just a tool. It automates build, test, and deploy so teams ship faster with fewer errors. GitHub Actions, Jenkins, and GitLab CI are tools that implement this practice.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
