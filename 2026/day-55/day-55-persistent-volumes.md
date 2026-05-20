# Day 55 – Persistent Volumes and PVCs

# PV and PVC

```yaml
# PersistentVolumeClaim
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

```yaml
# Mount in pod
volumeMounts:
  - name: data
    mountPath: /var/lib/data
volumes:
  - name: data
    persistentVolumeClaim:
      claimName: data-pvc
```

---

# Access Modes

| Mode | Meaning |
|---|---|
| ReadWriteOnce | One node read-write |
| ReadOnlyMany | Many nodes read-only |
| ReadWriteMany | Many nodes read-write |

---

# Verify

```bash
kubectl get pv
kubectl get pvc
kubectl describe pvc data-pvc
```

Data persists after pod deletion when using PVCs.

---

# Final Summary

PVs are cluster storage resources. PVCs are pod requests for storage. Data survives pod restarts and rescheduling.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
