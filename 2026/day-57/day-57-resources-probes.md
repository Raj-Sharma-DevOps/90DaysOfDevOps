# Day 57 – Resource Requests, Limits, and Probes

# Resource Management

```yaml
resources:
  requests:
    cpu: 250m
    memory: 256Mi
  limits:
    cpu: 500m
    memory: 512Mi
```

| Field | Purpose |
|---|---|
| requests | Guaranteed minimum resources for scheduling |
| limits | Maximum resources before throttling/OOMKill |

---

# Probes

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
```

| Probe | Purpose |
|---|---|
| liveness | Restart container if unhealthy |
| readiness | Remove from service endpoints if not ready |
| startup | Allow slow-starting containers time to boot |

---

# Final Summary

Resource limits prevent one pod from starving others. Probes enable self-healing and traffic management.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
