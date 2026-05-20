# Day 44 – Secrets, Artifacts and Running Real Tests in CI

# Task 1: GitHub Secrets

Added secrets in repo Settings → Secrets and variables → Actions:

| Secret | Purpose |
|---|---|
| `DOCKER_USERNAME` | Docker Hub login |
| `DOCKER_TOKEN` | Docker Hub access token |
| `API_KEY` | Example app secret |

Access in workflows: `${{ secrets.DOCKER_USERNAME }}`

---

# Task 2: Use Secrets in Workflow

```yaml
      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}
```

Secrets are masked in logs — never printed in plain text.

---

# Task 3: Artifacts

```yaml
      - name: Run tests and save report
        run: pytest --junitxml=report.xml

      - name: Upload test report
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: report.xml
          retention-days: 7
```

Artifacts persist after the job completes — downloadable from the Actions run page.

---

# Task 4: Download Artifacts

```yaml
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: test-results
```

Useful for passing build outputs between jobs or storing reports.

---

# Task 5: Real Tests in CI

```yaml
      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"
      - run: pip install -r requirements.txt
      - run: pytest tests/ -v
```

Pipeline fails if tests fail — CI doing its job.

---

# Final Summary

Secrets keep credentials out of code. Artifacts store build outputs and test reports. Real tests in CI catch bugs before merge.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
