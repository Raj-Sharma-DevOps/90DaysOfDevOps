# Day 79 – Creating a Custom Helm Chart for AI-BankApp

# Converted 12 Raw Manifests to Helm Chart

Raw manifests from `k8s/` → templated in `bankapp/templates/`:

| Raw File | Template |
|---|---|
| namespace.yml | templates/namespace.yaml |
| configmap.yml | templates/configmap.yaml |
| secrets.yml | templates/secrets.yaml |
| bankapp-deployment.yml | templates/bankapp-deployment.yaml |
| mysql-deployment.yml | templates/mysql-deployment.yaml |
| service.yml | templates/services.yaml |
| hpa.yml | templates/hpa.yaml |

---

# values.yaml

All hardcoded values extracted to configurable values:

```yaml
bankapp:
  replicaCount: 2
  image:
    repository: bankapp
    tag: latest
mysql:
  auth:
    rootPassword: changeme
    database: bankdb
```

---

# Render and Install

```bash
helm template bankapp ./bankapp
helm install bankapp ./bankapp -n bankapp --create-namespace
```

---

# Final Summary

Converted AI-BankApp raw K8s manifests into a reusable Helm chart with parameterized values.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
