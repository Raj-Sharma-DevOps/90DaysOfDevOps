# Day 67 – TerraWeek Capstone

# Multi-Environment with Workspaces

```bash
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
terraform workspace select dev
terraform apply -var-file=dev.tfvars
```

---

# Architecture

```text
modules/
├── vpc/
├── eks/
├── rds/
└── s3/

environments/
├── dev/
├── staging/
└── prod/
```

Each environment uses shared modules with different variable values.

---

# Final Summary

TerraWeek capstone: multi-environment infrastructure with modules, workspaces, and remote state.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
