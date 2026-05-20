# Day 69 – Ansible Playbooks and Modules

# Run Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/nginx.yml
ansible-playbook playbooks/nginx.yml --check  # dry run
ansible-playbook playbooks/nginx.yml --limit web1
```

---

# Common Modules

| Module | Purpose |
|---|---|
| apt/yum | Package management |
| service/systemd | Service control |
| copy/template | File management |
| user/group | User management |
| command/shell | Run commands |

---

# Final Summary

Playbooks define desired state declaratively. Idempotent — safe to run multiple times.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
