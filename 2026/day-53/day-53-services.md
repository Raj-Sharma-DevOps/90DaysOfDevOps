# Day 53 – Kubernetes Services

# Service Types

| Type | Use Case |
|---|---|
| ClusterIP | Internal communication (default) |
| NodePort | External access via node IP + port |
| LoadBalancer | Cloud provider load balancer |
| Headless | Direct pod DNS (StatefulSets) |

---

# ClusterIP Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
```

---

# NodePort Service

```yaml
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

```bash
kubectl port-forward svc/web-service 8080:80
minikube service web-service
```

---

# DNS Discovery

Pods reach services by name: `web-service.default.svc.cluster.local`

---

# Final Summary

Services provide stable networking to dynamic pods. ClusterIP for internal, NodePort/LoadBalancer for external access.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
