# Day 64 – Terraform State Management

# Local State

Default: `terraform.tfstate` in working directory. Contains mapping of resources to real infrastructure.

---

# Remote Backend (S3)

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

# State Commands

```bash
terraform state list
terraform state show aws_instance.web
terraform import aws_instance.web i-1234567890
terraform state mv aws_instance.old aws_instance.new
```

---

# Final Summary

Remote state enables team collaboration. State locking prevents concurrent modifications.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
