# Day 86 – GitOps Project: End-to-End CI/CD

# Pipeline Flow (gitops-ci.yml)

```text
Developer pushes code
    → GitHub Actions builds Docker image
    → Pushes to Docker Hub
    → Updates image tag in k8s/bankapp-deployment.yml
    → Commits change back to Git
    → ArgoCD detects change
    → Syncs new image to EKS cluster
```

---

# Key Pipeline Step

```bash
sed -i "s|image: REPO:.*|image: REPO:${SHA_SHORT}|" k8s/bankapp-deployment.yml
git add k8s/bankapp-deployment.yml
git commit -m "Update image to ${SHA_SHORT}"
git push
```

---

# End-to-End Verified

1. Code change pushed → pipeline triggered
2. Docker image built and pushed
3. Manifest updated in Git
4. ArgoCD synced new version to cluster
5. Application running with new image

---

# Final Summary

Complete GitOps pipeline: code → CI → Docker Hub → Git manifest update → ArgoCD → EKS. Zero manual deployment steps.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
