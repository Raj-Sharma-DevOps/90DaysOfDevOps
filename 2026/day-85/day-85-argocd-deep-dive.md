# Day 85 – ArgoCD Deep Dive

# Sync Strategies

| Strategy | Behavior |
|---|---|
| Auto sync | ArgoCD applies Git changes automatically |
| Manual sync | Admin triggers sync from UI/CLI |
| Self-heal | Reverts manual cluster changes back to Git state |
| Prune | Removes resources deleted from Git |

---

# Sync Waves

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "1"  # MySQL first
    argocd.argoproj.io/sync-wave: "2"  # App second
    argocd.argoproj.io/sync-wave: "3"  # Gateway last
```

---

# App of Apps Pattern

```yaml
# root-app.yaml manages child applications
spec:
  source:
    path: argocd-apps
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Manages bankapp, monitoring, and envoy-gateway as separate ArgoCD applications.

---

# Rollback

```bash
argocd app history bankapp
argocd app rollback bankapp 2
```

---

# Final Summary

Sync waves control deployment order. App of Apps manages multiple applications. Self-heal ensures cluster matches Git.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
