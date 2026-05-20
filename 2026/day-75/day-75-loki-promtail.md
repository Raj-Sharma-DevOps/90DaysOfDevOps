# Day 75 – Log Management with Loki and Promtail

# Architecture

```text
App logs → Promtail (collector) → Loki (storage) → Grafana (query/visualize)
```

---

# Promtail Config

```yaml
scrape_configs:
  - job_name: containers
    static_configs:
      - targets: [localhost]
        labels:
          job: containerlogs
          __path__: /var/lib/docker/containers/*/*-json.log
```

---

# LogQL Queries

```logql
{job="containerlogs"}                          # All container logs
{job="containerlogs"} |= "error"               # Filter errors
{job="containerlogs"} | json | level="ERROR"   # Parse JSON logs
rate({job="containerlogs"}[5m])                # Log rate
```

---

# Final Summary

Loki stores logs like Prometheus stores metrics. Promtail ships logs. Grafana queries both in one UI.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
