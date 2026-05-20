# Day 68 – Introduction to Ansible

# Setup

```bash
ansible --version
ansible all -i inventory/hosts.ini -m ping
ansible webservers -i inventory/hosts.ini -a "uptime"
```

---

# Ad-Hoc Commands

```bash
ansible webservers -m apt -a "name=nginx state=present" --become
ansible all -m shell -a "df -h"
ansible webservers -m copy -a "src=index.html dest=/var/www/html/"
```

---

# Key Concepts

| Concept | Description |
|---|---|
| Inventory | List of managed hosts |
| Module | Unit of work (apt, copy, service, shell) |
| Playbook | Ordered list of tasks |
| Become | Privilege escalation (sudo) |

---

# Final Summary

Ansible automates configuration management using SSH. No agent needed on target hosts.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
