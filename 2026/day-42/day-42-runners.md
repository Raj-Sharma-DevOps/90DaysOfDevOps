# Day 42 – Runners: GitHub-Hosted and Self-Hosted

# Task 1: GitHub-Hosted Runners

Used `runs-on: ubuntu-latest` in all workflows so far.

Available runners: `ubuntu-latest`, `windows-latest`, `macos-latest`

---

# Task 2: Compare Runners

| Runner | Best For |
|---|---|
| `ubuntu-latest` | Most CI/CD tasks, Docker builds, Linux tools |
| `windows-latest` | .NET apps, PowerShell scripts, Windows-specific builds |
| `macos-latest` | iOS/macOS builds (limited free minutes) |

---

# Task 3: Self-Hosted Runner Concept

Self-hosted runners run on your own machine or server:

```bash
# Download and configure (on your server)
./config.sh --url https://github.com/ORG/REPO --token TOKEN
./run.sh
```

Use when you need: custom hardware, internal network access, larger machines, or specific pre-installed tools.

---

# Task 4: Labels

Self-hosted runners use labels for job targeting:

```yaml
runs-on: [self-hosted, linux, gpu]
```

---

# Task 5: Runner Security

- Self-hosted runners execute arbitrary code from PRs — use with caution on public repos
- GitHub-hosted runners are ephemeral — fresh VM for each job
- Limit self-hosted runner access to trusted repositories

---

# Final Summary

GitHub-hosted runners are zero-config and perfect for most CI/CD. Self-hosted runners give control over hardware and network access for specialized needs.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
