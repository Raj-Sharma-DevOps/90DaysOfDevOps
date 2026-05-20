# Day 88 – Multi-Tool Agents, MCP, and CI/CD Analyzer

# MCP (Model Context Protocol)

Standard protocol for AI agents to connect to external tools and data sources.

```text
Agent ←→ MCP Server ←→ Tools (kubectl, docker, github)
```

---

# Multi-Tool Agent

Agent with access to:
- **kubectl** — inspect pods, logs, events
- **docker** — check images, containers
- **GitHub** — read workflow files, check CI status

---

# Broken Pod Demo

```bash
kubectl apply -f module-3/broken_pod.yaml
python module-3/k8s_agent.py
```

Agent detected CrashLoopBackOff → read logs → identified missing ConfigMap → suggested fix.

---

# CI/CD Analyzer

Agent reads `.github/workflows/gitops-ci.yml` and explains:
- Triggers, jobs, steps
- Potential issues (missing secrets, no test step)
- Suggestions for improvement

---

# Final Summary

Multi-tool agents with MCP can diagnose K8s issues and analyze CI/CD pipelines autonomously.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
