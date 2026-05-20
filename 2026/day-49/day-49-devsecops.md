# Day 49 – DevSecOps: Security in CI/CD

# Task 1: Trivy Docker Image Scan

```yaml
      - name: Scan Docker Image
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: '${{ secrets.DOCKER_USERNAME }}/task-manager-api:latest'
          format: 'table'
          exit-code: '1'
          severity: 'CRITICAL,HIGH'
```

Pipeline fails if CRITICAL or HIGH vulnerabilities found.

---

# Task 2: Secret Scanning with Gitleaks

```yaml
      - name: Scan for secrets
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Catches accidentally committed API keys, passwords, tokens.

---

# Task 3: Dependency Scanning

```yaml
      - name: Audit Python dependencies
        run: pip audit
```

Checks for known CVEs in Python packages.

---

# Task 4: Workflow Permissions

```yaml
permissions:
  contents: read
  packages: write
```

Principle of least privilege — workflow only gets access it needs.

---

# Task 5: SBOM Generation

```yaml
      - name: Generate SBOM
        uses: anchore/sbom-action@v0
        with:
          image: ${{ secrets.DOCKER_USERNAME }}/task-manager-api:latest
```

Software Bill of Materials lists all components in the image.

---

# DevSecOps Principles Applied

1. Catch vulnerabilities in PR, not production
2. Automate every security check
3. Block pipeline on critical findings
4. Never commit secrets — use GitHub Secrets
5. Limit workflow permissions

---

# Final Summary

DevSecOps = security checks integrated into the existing CI/CD pipeline. Scan images, scan secrets, audit dependencies — all before code reaches production.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
