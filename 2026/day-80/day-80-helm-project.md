# Day 80 – Helm Project: Multi-Environment Deployment

# Environment Values Files

| File | Replicas | Resources | Environment |
|---|---|---|---|
| values-dev.yaml | 1 | Low | Development |
| values-staging.yaml | 2 | Medium | Staging |
| values-prod.yaml | 3 | High | Production |

---

# Deploy Per Environment

```bash
helm install bankapp-dev bankapp/ -f bankapp/values-dev.yaml -n dev --create-namespace
helm install bankapp-staging bankapp/ -f bankapp/values-staging.yaml -n staging --create-namespace
helm install bankapp-prod bankapp/ -f bankapp/values-prod.yaml -n prod --create-namespace
```

---

# Helm Hooks

Pre-install job validates database connectivity before main deployment.

---

# CI/CD Integration

Pipeline updates `values-prod.yaml` image tag after Docker build → ArgoCD syncs the change.

---

# Final Summary

Multi-environment Helm deployment with values files, hooks, and CI/CD integration for the AI-BankApp.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
