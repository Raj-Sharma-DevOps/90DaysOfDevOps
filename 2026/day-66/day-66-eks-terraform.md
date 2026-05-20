# Day 66 – Provision EKS with Terraform Modules

# EKS Module Usage

```hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.medium"]
    }
  }
}
```

```bash
terraform init
terraform plan
terraform apply
kubectl get nodes
```

---

# Final Summary

Terraform modules simplify EKS provisioning — VPC, cluster, node groups in one configuration.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
