# Day 62 – Providers, Resources and Dependencies

# Multiple Resources with Dependencies

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "devops-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
}
```

Terraform infers dependencies from resource references.

---

# Explicit Dependency

```hcl
resource "aws_instance" "app" {
  depends_on = [aws_s3_bucket.logs]
}
```

---

# Final Summary

Resources reference each other for implicit dependencies. Use `depends_on` for explicit ordering when needed.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
