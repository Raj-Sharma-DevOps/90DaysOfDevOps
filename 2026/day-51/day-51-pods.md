# Day 51 – Kubernetes Manifests and First Pods

# Task 1: First Pod Manifest

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
```

```bash
kubectl apply -f nginx-pod.yaml
kubectl get pods
kubectl describe pod nginx-pod
```

---

# Task 2: Multi-Container Pod

```yaml
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "while true; do echo logging; sleep 5; done"]
    - name: logger
      image: busybox
      command: ["sh", "-c", "tail -f /dev/null"]
```

Sidecar pattern — helper container alongside main app.

---

# Task 3: Pod Lifecycle

```bash
kubectl get pods -w          # watch status changes
kubectl logs nginx-pod       # view logs
kubectl exec -it nginx-pod -- sh  # shell into pod
kubectl delete pod nginx-pod
```

Pod phases: Pending → Running → Succeeded/Failed

---

# Final Summary

Pods are the smallest deployable unit in Kubernetes. Manifests define desired state; kubectl applies them to the cluster.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
