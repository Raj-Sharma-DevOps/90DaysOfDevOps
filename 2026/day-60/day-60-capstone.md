# Day 60 – Capstone: WordPress + MySQL on Kubernetes

# Architecture

```text
Namespace: capstone
├── Secret (mysql-secret) ──► MySQL credentials
├── ConfigMap (wordpress-config) ──► DB host and name
├── StatefulSet (mysql) + Headless Service + PVC
├── Deployment (wordpress, 2 replicas) + NodePort Service
└── HPA (wordpress, 2-10 replicas, 50% CPU)
```

---

# Deploy

```bash
kubectl apply -f capstone/namespace.yaml
kubectl apply -f capstone/
kubectl config set-context --current --namespace=capstone
kubectl get all
```

---

# Verify MySQL

```bash
kubectl exec -it mysql-0 -- mysql -u wpuser -pwppass123 -e "SHOW DATABASES;"
```

---

# Access WordPress

```bash
kubectl port-forward svc/wordpress 8080:80 -n capstone
# Open http://localhost:8080
```

---

# Self-Healing Test

```bash
kubectl delete pod <wordpress-pod>
kubectl delete pod mysql-0
# Both recreated automatically; blog post persisted
```

---

# Concepts Used

| Concept | Day Learned |
|---|---|
| Namespace | 52 |
| Secret | 54 |
| ConfigMap | 54 |
| PVC | 55 |
| StatefulSet | 56 |
| Headless Service | 53, 56 |
| Deployment | 52 |
| NodePort Service | 53 |
| Resource Limits | 57 |
| Probes | 57 |
| HPA | 58 |
| Helm (bonus) | 59 |

---

# Cleanup

```bash
kubectl delete namespace capstone
kubectl config set-context --current --namespace=default
```

---

# Final Summary

Deployed a complete WordPress + MySQL stack using twelve Kubernetes concepts. Self-healing and data persistence verified.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
