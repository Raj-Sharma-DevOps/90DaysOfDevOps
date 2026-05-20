# Day 81 – Introduction to Amazon EKS with Terraform

# Reference: AI-BankApp-DevOps terraform/ configs

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

---

# EKS Cluster Created

- VPC with public/private subnets
- EKS control plane
- Managed node group (t3.medium × 2)
- EBS CSI driver for persistent volumes

---

# Deploy AI-BankApp

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/
kubectl get pods -n bankapp
```

---

# Verify

```bash
kubectl get nodes
kubectl get svc -n bankapp
```

---

# Final Summary

Provisioned EKS cluster with Terraform and deployed AI-BankApp manifests to managed Kubernetes on AWS.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
