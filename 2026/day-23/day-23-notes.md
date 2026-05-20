# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch in Git is a separate line of development. It allows developers to work on new features, bug fixes, or experiments without affecting the main codebase.

---

### 2. Why do we use branches instead of committing everything to main?

We use branches because:

- They keep the main branch stable
- Multiple developers can work independently
- Features and fixes can be tested safely
- Experimental code does not affect production code

---

### 3. What is HEAD in Git?

HEAD is a pointer that refers to the current branch or current commit we are working on in Git.

If HEAD points to `main`, all commits will go to the main branch.

---

### 4. What happens to your files when you switch branches?

When switching branches:

- Git updates the working directory according to that branch
- Files unique to another branch may disappear
- Files committed in the target branch appear automatically

Different branches can contain different versions of the project.

---

# Task 2: Branching Commands — Hands-On

## List all branches

```bash
git branch
```

---

## Create a new branch called feature-1

```bash
git branch feature-1
```

---

## Switch to feature-1

```bash
git switch feature-1
```

---

## Create and switch to feature-2 in a single command

```bash
git switch -c feature-2
```

---

## Difference between git switch and git checkout

| git checkout | git switch |
|---|---|
| Older command | Modern command |
| Used for branches and files | Used mainly for branch switching |
| More confusing | Cleaner and safer |

---

## Make a commit on feature-1

```bash
git switch feature-1
echo "Feature branch work" > feature.txt
git add .
git commit -m "Added feature.txt in feature-1"
```

---

## Switch back to main and verify commit is absent

```bash
git switch main
ls
```

The `feature.txt` file was not present in main branch because the commit exists only in `feature-1`.

---

## Delete unused branch

```bash
git branch -d feature-2
```

---

# Task 3: Push to GitHub

## Create remote repository

Created a GitHub repository without initializing README.

---

## Connect local repo to GitHub

```bash
git remote add origin https://github.com/your-username/devops-git-practice.git
```

---

## Push main branch

```bash
git push -u origin main
```

---

## Push feature-1 branch

```bash
git push -u origin feature-1
```

---

## Verified branches on GitHub

Both `main` and `feature-1` branches were visible on GitHub.

---

## Difference between origin and upstream

| origin | upstream |
|---|---|
| Your own remote repository | Original repository you forked from |
| Default remote after cloning | Used mainly in fork workflows |

Example:

- origin → your GitHub repo
- upstream → original open-source repo

---

# Task 4: Pull from GitHub

## Change made directly on GitHub

Edited a file using GitHub web editor.

---

## Pull latest changes locally

```bash
git pull origin main
```

---

## Difference between git fetch and git pull

| git fetch | git pull |
|---|---|
| Downloads latest changes only | Downloads + merges changes |
| Does not modify working directory | Updates working directory |
| Safer for checking changes first | Faster for direct updates |

---

# Task 5: Clone vs Fork

## Clone a public repository

```bash
git clone https://github.com/example/repo.git
```

---

## Fork and clone

1. Forked repository using GitHub
2. Cloned personal fork locally

```bash
git clone https://github.com/your-username/repo.git
```

---

## Difference between clone and fork

| Clone | Fork |
|---|---|
| Local copy of repository | Copy of repository on GitHub |
| Git command | GitHub feature |
| Used for downloading code | Used for contributing independently |

---

## When would you clone vs fork?

- Clone → when working on your own projects
- Fork → when contributing to someone else's repository

---

## How to keep fork synced with original repo

Add upstream remote:

```bash
git remote add upstream https://github.com/original-owner/repo.git
```

Fetch latest changes:

```bash
git fetch upstream
```

Merge changes into main:

```bash
git merge upstream/main
```

---

# Commands Added to git-commands.md

```bash
git branch
git branch feature-1
git switch feature-1
git switch -c feature-2
git branch -d feature-2

git add .
git commit -m "Added feature.txt in feature-1"

git remote add origin <repo-url>
git push -u origin main
git push -u origin feature-1

git pull origin main

git fetch upstream
git merge upstream/main

git clone <repo-url>

git remote add upstream <repo-url>
```

---

# Summary

Today I learned:

- Git branching workflow
- Switching between branches
- Creating isolated feature development
- Connecting local repositories to GitHub
- Difference between clone, fork, fetch, and pull
- Pushing branches to GitHub
- Working with remotes like origin and upstream

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
