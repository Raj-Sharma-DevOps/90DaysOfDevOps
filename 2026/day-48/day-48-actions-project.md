# Day 48 – GitHub Actions Capstone Project

# Pipeline Architecture

```text
PR opened → build & test → PR checks pass
Merge to main → build & test → Docker build & push → deploy
Every 12 hours → health check
```

---

# Workflows Created

| Workflow | Trigger | Purpose |
|---|---|---|
| `reusable-build-test.yml` | workflow_call | Shared build and test |
| `reusable-docker.yml` | workflow_call | Shared Docker build and push |
| `pr-pipeline.yml` | pull_request | Tests only on PRs |
| `main-pipeline.yml` | push to main | Full CI/CD with deploy |
| `health-check.yml` | cron + manual | Scheduled health verification |

---

# Key Patterns Used

- Reusable workflows with inputs, outputs, and secrets
- PR pipeline runs tests without Docker push
- Main pipeline runs full sequence with environment protection
- Scheduled health check with `$GITHUB_STEP_SUMMARY`

---

# What I'd Improve Next

- Slack notifications on deploy
- Multi-environment (staging → production)
- Automated rollback on health check failure
- Trivy security scanning (Day 49)

---

# Final Summary

Built a production-style CI/CD pipeline with reusable workflows, PR gates, main branch deployment, and scheduled health checks.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
