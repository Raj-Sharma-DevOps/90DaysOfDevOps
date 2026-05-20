# Day 87 – Introduction to Agentic AI for DevOps

# Reference: agentic-ai-for-devops repo

# What is Agentic AI?

AI agents that can:
- Reason about infrastructure problems
- Use tools (kubectl, docker, git) autonomously
- Take multi-step actions to diagnose and fix issues

---

# ReAct Pattern

```text
Thought → Action → Observation → Thought → Action → ...
```

Agent thinks, picks a tool, observes result, repeats until problem solved.

---

# Setup

```bash
git clone https://github.com/TrainWithShubham/agentic-ai-for-devops.git
cd agentic-ai-for-devops
pip install -r requirements.txt
export OPENAI_API_KEY=your-key
python module-1/simple_agent.py
```

---

# Simple Agent Demo

Agent receives: "Why is my pod crashing?"
Agent uses kubectl tool → reads logs → identifies OOMKill → suggests increasing memory limit.

---

# Final Summary

Agentic AI brings autonomous reasoning to DevOps — agents that diagnose and propose fixes using real tools.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
