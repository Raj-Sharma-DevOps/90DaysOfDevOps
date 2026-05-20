# Day 38 – YAML Basics

# Task 1: Key-Value Pairs

## person.yaml

```yaml
name: Raj
role: DevOps Engineer
experience_years: 2
learning: true
```

---

## Verify

```bash
cat person.yaml
```

Output is clean with spaces only — no tabs.

---

# Task 2: Lists

## Added to person.yaml

```yaml
tools:
  - Linux
  - Docker
  - Kubernetes
  - Terraform
  - GitHub Actions
hobbies: [reading, hiking, coding]
```

---

## Two Ways to Write a List in YAML

1. **Block style** — each item on its own line with `-`
2. **Inline style** — `[item1, item2, item3]`

Both are equivalent; block style is easier to read for long lists.

---

# Task 3: Nested Objects

## server.yaml

```yaml
server:
  name: devops-web-01
  ip: 192.168.1.100
  port: 8080

database:
  host: db.internal.local
  name: production_db
  credentials:
    user: app_user
    password: "${DB_PASSWORD}"
```

---

## Tab vs Spaces Test

When a tab is used instead of spaces, YAML parsers throw an error:

```text
found character '\t' that cannot start any token
```

YAML requires **spaces only** for indentation.

---

# Task 4: Multi-line Strings

## Block Style (`|`)

```yaml
startup_script: |
  #!/bin/bash
  echo "Starting application server..."
  systemctl start nginx
  systemctl start myapp
  echo "Server ready on port 8080"
```

Preserves newlines — good for scripts and configs.

---

## Fold Style (`>`)

```yaml
startup_command: >
  This is a folded multi-line string
  that becomes a single line
  when parsed by YAML.
```

Folds into one line — good for long sentences and commands.

---

## When to Use `|` vs `>`

| Style | Use When |
|---|---|
| `\|` (literal) | Newlines matter — scripts, Dockerfiles, shell commands |
| `>` (folded) | Newlines don't matter — long descriptions, single-line commands |

---

# Task 5: Validate Your YAML

## Install yamllint

```bash
pip install yamllint
yamllint person.yaml server.yaml
```

---

## Intentionally Break Indentation

```yaml
name: devops
tools:
- docker
  - kubernetes   # WRONG — inconsistent indentation
```

Error:

```text
error: syntax error: expected <block end>, but found '-'
```

---

## Fix and Re-validate

After fixing indentation to consistent 2-space levels, validation passes.

---

# Task 6: Spot the Difference

## Block 1 — Correct

```yaml
name: devops
tools:
  - docker
  - kubernetes
```

---

## Block 2 — Broken

```yaml
name: devops
tools:
- docker
  - kubernetes
```

---

## What's Wrong?

The list items have **inconsistent indentation**. `- docker` is at the same level as `tools:`, but `- kubernetes` is indented further. YAML requires all list items at the same indentation level under their parent key.

---

# Key Learnings

1. **Spaces only** — tabs break YAML parsers
2. **Indentation defines structure** — 2 spaces is the standard
3. **Three data types dominate** — scalars (key: value), lists (- item), maps (nested keys)

---

# Final Summary

YAML is the foundation of every CI/CD pipeline, Kubernetes manifest, and Docker Compose file. Getting syntax right early saves hours of debugging later.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
