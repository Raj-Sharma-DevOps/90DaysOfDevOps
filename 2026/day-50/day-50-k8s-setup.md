# Day 50 – Kubernetes Architecture and Cluster Setup

# Task 1: The Kubernetes Story

1. **Why Kubernetes?** Docker runs containers on one machine. Kubernetes orchestrates containers across many machines — scheduling, scaling, self-healing, load balancing.
2. **Who created it?** Google, inspired by their internal Borg system. Donated to CNCF in 2014.
3. **Name meaning:** Greek for "helmsman" or "pilot" — steers container workloads.

---

# Task 2: Architecture

```text
CONTROL PLANE                    WORKER NODE
┌─────────────┐                 ┌─────────────┐
│ API Server  │◄───────────────►│   kubelet   │
│    etcd     │                 │ kube-proxy  │
│  Scheduler  │                 │  containerd │
│ Controller  │                 │    Pods     │
└─────────────┘                 └─────────────┘
```

**kubectl apply flow:** kubectl → API Server → etcd stores state → Scheduler assigns node → kubelet creates pod.

---

# Task 3-4: Install kubectl and Create Cluster

```bash
kubectl version --client
kind create cluster --name devops-cluster
kubectl cluster-info
kubectl get nodes
```

Chose **kind** because it runs clusters inside Docker containers — lightweight and fast.

---

# Task 5: Explore Cluster

```bash
kubectl get namespaces
kubectl get pods -A
kubectl get pods -n kube-system
kubectl describe node devops-cluster-control-plane
```

kube-system pods map to architecture: etcd, kube-apiserver, kube-scheduler, kube-controller-manager, coredns, kube-proxy.

---

# Task 6: Cluster Lifecycle

```bash
kind delete cluster --name devops-cluster
kind create cluster --name devops-cluster
kubectl config current-context
kubectl config get-contexts
```

**kubeconfig** stored at `~/.kube/config` — contains cluster URLs, credentials, and context.

---

# Final Summary

Set up local Kubernetes with kind, explored control plane components running as pods, and practiced cluster lifecycle commands.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
