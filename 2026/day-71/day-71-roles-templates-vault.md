# Day 71 – Roles, Galaxy, Templates and Vault

# Create Role

```bash
ansible-galaxy init nginx
```

```text
roles/nginx/
├── tasks/main.yml
├── handlers/main.yml
├── templates/nginx.conf.j2
├── vars/main.yml
└── defaults/main.yml
```

---

# Jinja2 Template

```jinja2
# templates/nginx.conf.j2
server {
    listen {{ http_port }};
    server_name {{ server_name }};
}
```

---

# Ansible Vault

```bash
ansible-vault create secrets.yml
ansible-vault encrypt_string 'mypassword' --name 'db_password'
ansible-playbook site.yml --ask-vault-pass
```

---

# Galaxy

```bash
ansible-galaxy install geerlingguy.docker
```

---

# Final Summary

Roles organize playbooks into reusable units. Vault encrypts secrets. Galaxy provides community roles.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
