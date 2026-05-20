# Day 52 – Namespaces and Deployments

# Task 1: Namespaces

```bash
kubectl create namespace dev
kubectl create namespace staging
kubectl get namespaces
kubectl config set-context --current --namespace=dev
```

Namespaces isolate resources within a cluster.

---

# Task 2: Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: dev
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
```

```bash
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl get pods -l app=web
```

---

# Task 3: Self-Healing

```bash
kubectl delete pod <pod-name>
kubectl get pods -w  # Deployment recreates it automatically
```

---

# Task 4: Scaling

```bash
kubectl scale deployment web-app --replicas=5
kubectl get pods
```

---

# Final Summary

Deployments manage ReplicaSets which manage Pods. They provide self-healing, scaling, and rolling updates.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
