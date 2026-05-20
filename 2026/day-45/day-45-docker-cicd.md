# Day 45 – Docker Build & Push in GitHub Actions

# Task 1: Prepare

Used the Day 36 Task Manager API Dockerfile in the `github-actions-practice` repo.

Secrets `DOCKER_USERNAME` and `DOCKER_TOKEN` configured from Day 44.

---

# Task 2-3: Build and Push

## .github/workflows/docker-publish.yml

```yaml
name: Docker Publish

on:
  push:
    branches: [main, "feature/**"]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t task-manager-api:${{ github.sha }} .

      - name: Log in to Docker Hub
        if: github.ref == 'refs/heads/main'
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Tag and push
        if: github.ref == 'refs/heads/main'
        run: |
          SHORT_SHA=$(echo "${{ github.sha }}" | cut -c1-7)
          docker tag task-manager-api:${{ github.sha }} \
            ${{ secrets.DOCKER_USERNAME }}/task-manager-api:latest
          docker tag task-manager-api:${{ github.sha }} \
            ${{ secrets.DOCKER_USERNAME }}/task-manager-api:sha-$SHORT_SHA
          docker push ${{ secrets.DOCKER_USERNAME }}/task-manager-api:latest
          docker push ${{ secrets.DOCKER_USERNAME }}/task-manager-api:sha-$SHORT_SHA
```

---

# Task 4: Only Push on Main

The `if: github.ref == 'refs/heads/main'` condition ensures:

- Feature branch push → image built, NOT pushed
- Main branch push → image built AND pushed with `latest` and `sha-*` tags

---

# Task 5: Status Badge

Added to README.md:

```markdown
![Docker Publish](https://github.com/USERNAME/github-actions-practice/actions/workflows/docker-publish.yml/badge.svg)
```

---

# Final Summary

Complete CI/CD pipeline: push to GitHub → build Docker image → push to Docker Hub automatically. No manual steps.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
