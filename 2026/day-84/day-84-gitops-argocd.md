# Day 84 – Introduction to GitOps and ArgoCD

# GitOps Principles

1. **Git is the single source of truth** — all config lives in a repo
2. **Declarative** — describe desired state, not steps
3. **Automated sync** — ArgoCD watches Git and applies changes
4. **Continuous reconciliation** — cluster always matches repo

---

# Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

---

# Application Manifest

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bankapp
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/USER/AI-BankApp-DevOps
    targetRevision: feat/gitops
    path: k8s
  destination:
    server: https://kubernetes.default.svc
    namespace: bankapp
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

---

# Final Summary

ArgoCD continuously syncs Kubernetes state from Git. Push a change → ArgoCD deploys it automatically.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
