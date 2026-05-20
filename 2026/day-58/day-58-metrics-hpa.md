# Day 58 – Metrics Server and HPA

# Install Metrics Server

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl top nodes
kubectl top pods
```

---

# Horizontal Pod Autoscaler

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```

```bash
kubectl apply -f hpa.yaml
kubectl get hpa
kubectl describe hpa web-hpa
```

---

# Load Test

```bash
kubectl run load --image=busybox -- sh -c "while true; do wget -q -O- http://web-service; done"
kubectl get hpa -w  # watch replicas increase
```

---

# Final Summary

Metrics Server collects resource usage. HPA automatically scales pods based on CPU, memory, or custom metrics.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
