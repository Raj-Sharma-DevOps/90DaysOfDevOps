# Day 63 – Variables, Outputs, Data Sources

# Variables

```hcl
variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "instance_count" {
  type    = number
  default = 2
}
```

Usage: `var.environment`, `var.instance_count`

---

# Outputs

```hcl
output "instance_ips" {
  value = aws_instance.web[*].public_ip
}
```

---

# Data Sources

```hcl
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}
```

Read existing infrastructure without managing it.

---

# Final Summary

Variables parameterize config. Outputs expose values. Data sources query existing resources.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
