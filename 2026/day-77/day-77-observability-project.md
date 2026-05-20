# Day 77 – Observability Project: Full Stack

# Full Stack Deployed

Using observability-for-devops Docker Compose:

| Component | Port | Purpose |
|---|---|---|
| Prometheus | 9090 | Metrics collection |
| Grafana | 3000 | Dashboards |
| Loki | 3100 | Log storage |
| Promtail | — | Log shipping |
| OTEL Collector | 4317 | Traces and metrics |
| Node Exporter | 9100 | Host metrics |
| cAdvisor | 8080 | Container metrics |

---

# Verification

```bash
docker compose ps
curl http://localhost:9090/api/v1/targets
curl http://localhost:3000
```

All targets UP in Prometheus. Grafana dashboards showing live metrics and logs.

---

# Final Summary

Full observability stack running with Docker Compose — metrics, logs, and traces in one platform.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
