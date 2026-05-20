# Day 90 – Grand Finale: The Complete DevOps Journey

# 90-Day Timeline

| Week | Days | Topic | Key Skills |
|---|---|---|---|
| 1-2 | 1-13 | Linux Fundamentals | Commands, permissions, LVM |
| 2 | 14-15 | Networking | DNS, IP, subnets, ports |
| 3 | 16-21 | Shell Scripting | Bash, functions, automation |
| 3-4 | 22-28 | Git & GitHub | Branching, CLI, profile |
| 4-5 | 29-37 | Docker | Images, Compose, multi-stage |
| 5-7 | 38-49 | CI/CD | YAML, GitHub Actions, DevSecOps |
| 7-8 | 50-60 | Kubernetes | Pods, Deployments, Helm, capstone |
| 8-9 | 61-67 | Terraform | IaC, modules, EKS |
| 9-10 | 68-72 | Ansible | Playbooks, roles, automation |
| 10-11 | 73-77 | Observability | Prometheus, Grafana, Loki |
| 11-12 | 78-86 | Helm, EKS, GitOps | Charts, ArgoCD, AI-BankApp |
| 12-13 | 87-89 | Agentic AI | LLM agents, MCP, KubeHealer |

---

# Top 5 Aha Moments

1. **Multi-stage Docker builds** — 850 MB to 15 MB. Same app, tiny image.
2. **GitHub Actions green checkmark** — CI/CD stopped being theory and became real.
3. **kubectl get pods -n kube-system** — seeing control plane components as actual running pods.
4. **ArgoCD sync** — push to Git, watch the cluster update automatically. GitOps clicked.
5. **KubeHealer** — an AI agent diagnosing and fixing a crashing pod autonomously.

---

# Hardest Day

**Day 60 (Kubernetes Capstone)** — wiring twelve concepts (Namespace, Secret, ConfigMap, PVC, StatefulSet, Headless Service, Deployment, NodePort, probes, HPA) into one working WordPress + MySQL stack. The `WORDPRESS_DB_HOST` DNS pattern took multiple attempts to get right.

---

# Skills Inventory

| Skill | Days | Confidence |
|---|---|---|
| Linux command line | 1-13 | 4/5 |
| Shell scripting | 16-21 | 4/5 |
| Git & GitHub | 22-28 | 4/5 |
| Docker | 29-37 | 5/5 |
| CI/CD (GitHub Actions) | 38-49 | 4/5 |
| Kubernetes | 50-60 | 4/5 |
| Terraform | 61-67 | 3/5 |
| Ansible | 68-72 | 3/5 |
| Observability | 73-77 | 3/5 |
| Helm | 78-80 | 4/5 |
| Amazon EKS | 81-83 | 3/5 |
| ArgoCD / GitOps | 84-86 | 4/5 |
| Agentic AI for DevOps | 87-89 | 3/5 |

---

# End-to-End Pipeline Traced

```text
Code on Linux → Shell scripts automate tasks → Git version control
→ Push triggers GitHub Actions → Docker image built and pushed
→ Manifest updated in Git → ArgoCD syncs to EKS
→ EKS provisioned by Terraform → Configured by Ansible
→ Helm manages deployment → Prometheus/Grafana/Loki monitor
→ KubeHealer AI agent fixes issues → Cycle continues
```

---

# What Comes Next

1. **CKA certification** — deepen Kubernetes knowledge
2. **Portfolio project** — build own app with full GitOps pipeline
3. **Service mesh** — explore Istio for advanced traffic management
4. **HashiCorp Vault** — production secrets management

---

# Advice for Day 1 Starters

1. **Show up daily** — consistency beats intensity
2. **Hands-on everything** — don't just read, run the commands
3. **Break things on purpose** — best learning comes from fixing errors
4. **Share publicly** — LinkedIn posts keep you accountable
5. **Connect the dots** — every tool fits into a pipeline, nothing is isolated

---

# Final Words

90 days from `ls` to AI-powered self-healing agents. The tools will change, but the patterns — IaC, containerization, orchestration, observability, GitOps, automation — stay. This foundation makes learning any new tool a weekend project, not a month-long struggle.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
