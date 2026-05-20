# Day 74 – Node Exporter, cAdvisor, and Grafana Dashboards

# Exporters

| Exporter | Metrics |
|---|---|
| Node Exporter | CPU, memory, disk, network (host level) |
| cAdvisor | Container CPU, memory, network (per container) |

---

# Grafana Dashboard Setup

1. Add Prometheus as data source (http://prometheus:9090)
2. Import dashboard ID 1860 (Node Exporter Full)
3. Import dashboard ID 893 (Docker and System Monitoring)

---

# Key Panels

- CPU usage over time
- Memory available vs used
- Disk I/O
- Container resource usage

---

# Final Summary

Exporters expose metrics. Grafana visualizes them in dashboards for real-time system visibility.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
