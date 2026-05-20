# Day 59 – Helm Package Manager

# Install Helm

```bash
helm version
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

---

# Install a Chart

```bash
helm install my-nginx bitnami/nginx
helm list
kubectl get pods
```

---

# Customize with Values

```bash
helm install my-nginx bitnami/nginx \
  --set service.type=NodePort \
  --set replicaCount=3
```

---

# Upgrade and Rollback

```bash
helm upgrade my-nginx bitnami/nginx --set replicaCount=5
helm history my-nginx
helm rollback my-nginx 1
```

---

# Uninstall

```bash
helm uninstall my-nginx
```

---

# Final Summary

Helm packages Kubernetes manifests into reusable charts with configurable values. Install, upgrade, rollback with one command.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
