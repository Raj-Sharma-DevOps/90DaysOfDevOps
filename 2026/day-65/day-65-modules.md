# Day 65 – Terraform Modules

# Module Structure

```text
modules/ec2/
├── main.tf
├── variables.tf
└── outputs.tf
```

---

# Using a Module

```hcl
module "web_server" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  environment   = "production"
}

output "web_ip" {
  value = module.web_server.public_ip
}
```

---

# Benefits

- Reusable infrastructure components
- Consistent patterns across environments
- DRY — define once, use many times

---

# Final Summary

Modules encapsulate reusable infrastructure. Compose complex environments from simple building blocks.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
