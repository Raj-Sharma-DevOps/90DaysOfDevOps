# Day 83 – EKS Project: Production Deployment

# Full Production Stack

Deployed AI-BankApp on EKS with:

1. All K8s manifests (namespace, config, secrets, deployments, services, HPA)
2. Gateway API for external access
3. Prometheus ServiceMonitor for metrics
4. EBS-backed persistent storage
5. Health checks and resource limits

---

# Monitoring

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: bankapp-monitor
spec:
  selector:
    matchLabels:
      app: bankapp
  endpoints:
    - port: http
      path: /actuator/prometheus
```

---

# Production Checklist

- [x] Resource requests and limits
- [x] Liveness and readiness probes
- [x] HPA for autoscaling
- [x] Persistent storage for database
- [x] TLS on Gateway
- [x] Monitoring with Prometheus

---

# Final Summary

Full production deployment of AI-BankApp on EKS — networking, storage, monitoring, and autoscaling.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
