# Day 73 – Introduction to Observability and Prometheus

# Three Pillars

| Pillar | Tool | Question Answered |
|---|---|---|
| Metrics | Prometheus | What is the system's performance? |
| Logs | Loki | What happened and when? |
| Traces | OpenTelemetry | Where did the request go? |

---

# Setup (observability-for-devops repo)

```bash
git clone https://github.com/LondheShubham153/observability-for-devops.git
cd observability-for-devops
docker compose up -d
```

Prometheus: http://localhost:9090
Grafana: http://localhost:3000

---

# PromQL Basics

```promql
up                                    # Target health
rate(http_requests_total[5m])         # Request rate
node_memory_MemAvailable_bytes        # Available memory
```

---

# Final Summary

Observability goes beyond monitoring — it helps understand WHY systems behave the way they do. Prometheus collects and stores metrics.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
