# Day 89 – Production AI Agents: KubeHealer and AIOps

# Reference: kubehealer repo

# KubeHealer Architecture

```text
Kubernetes Events → KubeHealer Agent → Diagnosis → Fix Proposal → Temporal Workflow → Apply Fix
```

---

# Components

| Component | Role |
|---|---|
| Event Watcher | Monitors K8s events (CrashLoop, OOMKill, Pending) |
| LLM Agent | Reasons about root cause |
| Tool Executor | Runs kubectl commands safely |
| Temporal | Orchestrates multi-step remediation workflows |

---

# Demo Scenario

1. Deploy pod with insufficient memory
2. KubeHealer detects OOMKill event
3. Agent reads pod spec and events
4. Proposes: increase memory limit from 128Mi to 512Mi
5. Temporal workflow applies the fix
6. Pod recovers

---

# AIOps Vision

```text
Detect → Diagnose → Decide → Act → Verify → Learn
```

AI agents close the loop from detection to remediation without human intervention.

---

# Final Summary

KubeHealer demonstrates production AIOps — autonomous detection, diagnosis, and remediation of Kubernetes issues.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
