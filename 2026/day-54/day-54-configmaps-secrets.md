# Day 54 – ConfigMaps and Secrets

# ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_ENV: production
  LOG_LEVEL: info
  config.json: |
    {"feature_flags": {"dark_mode": true}}
```

Use in pod:

```yaml
envFrom:
  - configMapRef:
      name: app-config
```

---

# Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
stringData:
  DB_USER: admin
  DB_PASSWORD: s3cretP@ss
```

Use in pod:

```yaml
env:
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_PASSWORD
```

---

# Key Differences

| | ConfigMap | Secret |
|---|---|---|
| Purpose | Non-sensitive config | Sensitive data |
| Encoding | Plain text | Base64 (not encryption) |
| Size limit | 1 MB | 1 MB |

---

# Final Summary

ConfigMaps for app configuration, Secrets for credentials. Both decouple config from container images.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
