# Day 82 – EKS Networking and Persistent Storage

# Gateway API with Envoy

Applied `k8s/gateway.yml`:

- GatewayClass → Envoy Gateway controller
- Gateway → HTTP/HTTPS listeners
- HTTPRoute → routes traffic to bankapp service

---

# EBS Persistent Storage

```yaml
# StorageClass with EBS CSI
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
```

PVCs for MySQL (5Gi) and Ollama (10Gi) bound to EBS volumes.

---

# TLS with cert-manager

ClusterIssuer for Let's Encrypt → TLS certificate on Gateway.

---

# Session Persistence

Cookie-based session affinity on HTTPRoute for stateful user sessions.

---

# Final Summary

Production EKS networking with Gateway API, EBS persistent storage, and TLS termination.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
