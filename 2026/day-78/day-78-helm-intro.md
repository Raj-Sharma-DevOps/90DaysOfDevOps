# Day 78 – Introduction to Helm and Chart Basics

# Reference: AI-BankApp-DevOps (feat/gitops branch)

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install bankapp-mysql bitnami/mysql \
  --set auth.rootPassword=secret \
  --set auth.database=bankdb \
  -n bankapp --create-namespace
```

---

# Chart Structure

```text
chart/
├── Chart.yaml
├── values.yaml
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── _helpers.tpl
└── charts/
```

---

# Commands

```bash
helm install RELEASE CHART
helm list -n NAMESPACE
helm upgrade RELEASE CHART --set key=value
helm uninstall RELEASE
helm template RELEASE CHART  # dry-run render
```

---

# Final Summary

Helm packages K8s manifests into charts with configurable values. One chart, many deployments.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
