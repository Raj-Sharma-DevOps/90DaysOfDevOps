# Day 70 – Variables, Facts, Conditionals and Loops

# Variables

```yaml
vars:
  app_port: 8080
  app_user: deploy

tasks:
  - debug:
      msg: "App running on port {{ app_port }}"
```

---

# Facts

```yaml
  - debug:
      msg: "OS is {{ ansible_distribution }} {{ ansible_distribution_version }}"
```

```bash
ansible webservers -m setup
```

---

# Conditionals and Loops

```yaml
  - name: Install packages
    apt:
      name: "{{ item }}"
      state: present
    loop:
      - nginx
      - curl
      - git
    when: ansible_os_family == "Debian"
```

---

# Final Summary

Variables parameterize playbooks. Facts gather system info. Loops and conditionals handle dynamic scenarios.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
