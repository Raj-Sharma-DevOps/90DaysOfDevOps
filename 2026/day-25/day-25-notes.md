# Day 25 – Git Reset vs Revert & Branching Strategies

# Task 1: Git Reset — Hands-On

## Create 3 commits

```bash
echo "Commit A" > reset.txt
git add .
git commit -m "Commit A"

echo "Commit B" >> reset.txt
git add .
git commit -m "Commit B"

echo "Commit C" >> reset.txt
git add .
git commit -m "Commit C"
```

---

## Git Reset --soft

```bash
git reset --soft HEAD~1
```

### Observation

- Last commit was removed from history
- Changes from the removed commit stayed staged
- Files were not deleted

---

## Re-commit changes

```bash
git commit -m "Re-added Commit C"
```

---

## Git Reset --mixed

```bash
git reset --mixed HEAD~1
```

### Observation

- Last commit was removed
- Changes stayed in working directory
- Changes became unstaged

---

## Re-commit changes

```bash
git add .
git commit -m "Re-added Commit C again"
```

---

## Git Reset --hard

```bash
git reset --hard HEAD~1
```

### Observation

- Last commit was removed permanently
- Changes were deleted from working directory
- Working directory matched previous commit exactly

---

## Difference between --soft, --mixed, and --hard

| Command | Commit Removed | Changes Kept | Staging Area |
|---|---|---|---|
| --soft | Yes | Yes | Staged |
| --mixed | Yes | Yes | Unstaged |
| --hard | Yes | No | Deleted |

---

## Which one is destructive and why?

`git reset --hard` is destructive because it permanently deletes commits and file changes from the working directory.

---

## When would you use each one?

- `--soft` → when changing commit message or combining commits
- `--mixed` → when keeping file changes but unstaging them
- `--hard` → when completely discarding unwanted changes

---

## Should you use reset on pushed commits?

No. Reset rewrites history and can create problems for collaborators if commits were already pushed.

---

# Task 2: Git Revert — Hands-On

## Create commits X, Y, Z

```bash
echo "Commit X" > revert.txt
git add .
git commit -m "Commit X"

echo "Commit Y" >> revert.txt
git add .
git commit -m "Commit Y"

echo "Commit Z" >> revert.txt
git add .
git commit -m "Commit Z"
```

---

## Revert commit Y

Find commit hash:

```bash
git log --oneline
```

Example:

```bash
abc1234 Commit Y
```

Revert commit:

```bash
git revert abc1234
```

---

## Observation

- Git created a new commit that reversed changes from Commit Y
- Original commit Y still remained in history

---

## Is commit Y still in history?

Yes. Git revert does not remove commits from history.

---

## Difference between git revert and git reset

| git reset | git revert |
|---|---|
| Removes commits from history | Creates new commit to undo changes |
| Rewrites history | Preserves history |
| Dangerous for shared branches | Safe for shared branches |

---

## Why is revert safer for shared branches?

Because revert does not rewrite commit history, other developers are not affected.

---

## When would you use revert vs reset?

- Use revert for shared/public branches
- Use reset for local cleanup before pushing

---

# Task 3: Reset vs Revert — Summary

| Feature | git reset | git revert |
|---|---|---|
| What it does | Moves HEAD backward | Creates undo commit |
| Removes commit from history? | Yes | No |
| Safe for pushed branches? | No | Yes |
| When to use | Local cleanup | Undoing public commits |

---

# Task 4: Branching Strategies

# 1. GitFlow

## How it works

GitFlow uses multiple branches like:

- main
- develop
- feature
- release
- hotfix

Development happens in feature branches and later merges into develop and main.

---

## Flow Diagram

```text
main
  |
develop
 |   \
feature  release
           \
          hotfix
```

---

## Where it's used

- Large teams
- Enterprise projects
- Scheduled release cycles

---

## Pros

- Organized workflow
- Good release management
- Stable production branch

---

## Cons

- Complex
- Too many branches
- Slower development speed

---

# 2. GitHub Flow

## How it works

- Single main branch
- Create feature branch
- Open Pull Request
- Review and merge into main

---

## Flow Diagram

```text
main
  \
 feature-branch
      \
      merge back to main
```

---

## Where it's used

- Startups
- SaaS products
- Fast deployments

---

## Pros

- Simple workflow
- Easy collaboration
- Fast releases

---

## Cons

- Less structured
- Harder for big release cycles

---

# 3. Trunk-Based Development

## How it works

Developers commit directly to main or use very short-lived branches.

---

## Flow Diagram

```text
main
 | | | |
small frequent commits
```

---

## Where it's used

- High-speed engineering teams
- CI/CD-heavy environments

---

## Pros

- Fast integration
- Fewer merge conflicts
- Excellent for continuous delivery

---

## Cons

- Requires strong testing automation
- Risky without CI/CD

---

# Which strategy would you use for a startup shipping fast?

GitHub Flow because it is simple and supports rapid deployment.

---

# Which strategy would you use for a large team with scheduled releases?

GitFlow because it provides structured release management.

---

# Which strategy does an open-source project use?

:contentReference[oaicite:0]{index=0} mainly uses GitHub-style workflows with feature branches and pull requests.

---

# Task 5: Git Commands Reference Update

# Setup & Config

```bash
git init
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

# Basic Workflow

```bash
git status
git add .
git commit -m "message"
git log
git diff
```

---

# Branching

```bash
git branch
git switch branch-name
git switch -c new-branch
git checkout branch-name
```

---

# Remote Operations

```bash
git remote add origin <repo-url>
git push -u origin main
git pull origin main
git fetch
git clone <repo-url>
```

---

# Merge & Rebase

```bash
git merge branch-name
git merge --squash branch-name
git rebase main
git log --oneline --graph --all
```

---

# Stash & Cherry Pick

```bash
git stash
git stash push -m "message"
git stash list
git stash pop
git stash apply stash@{0}

git cherry-pick <commit-hash>
```

---

# Reset & Revert

```bash
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1

git revert <commit-hash>

git reflog
```

---

# Summary

Today I learned:

- Difference between reset and revert
- Soft, mixed, and hard reset
- Safe undo operations using revert
- Real-world branching strategies
- GitFlow vs GitHub Flow vs Trunk-Based Development
- Importance of reflog as a recovery tool

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
