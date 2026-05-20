# Day 56 – StatefulSets

# StatefulSet vs Deployment

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random | Ordered, predictable (app-0, app-1) |
| Storage | Shared or none | Per-pod PVC via volumeClaimTemplates |
| Networking | Random IP | Stable DNS per pod |
| Scaling | Any order | Ordered (0, 1, 2...) |
| Use case | Stateless apps | Databases, queues |

---

# StatefulSet Example

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    spec:
      containers:
        - name: mysql
          image: mysql:8.0
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
```

Headless Service required: `clusterIP: None`

DNS: `mysql-0.mysql.default.svc.cluster.local`

---

# Final Summary

StatefulSets provide stable identity and persistent storage for stateful applications like databases.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
