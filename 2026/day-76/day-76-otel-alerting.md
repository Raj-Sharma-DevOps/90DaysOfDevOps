# Day 76 – OpenTelemetry and Alerting

# OpenTelemetry Collector

Receives, processes, and exports traces, metrics, and logs.

```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317

exporters:
  prometheus:
    endpoint: 0.0.0.0:8889

service:
  pipelines:
    metrics:
      receivers: [otlp]
      exporters: [prometheus]
```

---

# Alerting Rules

```yaml
groups:
  - name: instance_alerts
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Instance {{ $labels.instance }} is down"
```

---

# Alertmanager

Routes alerts to Slack, PagerDuty, email based on severity and labels.

---

# Final Summary

OpenTelemetry provides vendor-neutral instrumentation. Alerting rules turn metrics into actionable notifications.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
