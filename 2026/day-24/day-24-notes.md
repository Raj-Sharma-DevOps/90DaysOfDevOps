# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

# Task 1: Git Merge — Hands-On

## Create feature-login branch and add commits

```bash
git switch main
git switch -c feature-login

echo "Login page created" > login.txt
git add .
git commit -m "Added login page"

echo "Login validation added" >> login.txt
git add .
git commit -m "Added login validation"
```

---

## Merge feature-login into main

```bash
git switch main
git merge feature-login
```

Git performed a **fast-forward merge** because no new commits existed on `main`.

---

## Create feature-signup branch

```bash
git switch -c feature-signup

echo "Signup page" > signup.txt
git add .
git commit -m "Added signup page"
```

---

## Add commit to main before merging

```bash
git switch main

echo "Main branch update" > main-update.txt
git add .
git commit -m "Updated main branch"
```

---

## Merge feature-signup into main

```bash
git merge feature-signup
```

Git created a **merge commit** because both branches had different commit histories.

---

## What is a fast-forward merge?

A fast-forward merge happens when the target branch has no new commits and Git can simply move the branch pointer forward.

---

## When does Git create a merge commit?

Git creates a merge commit when both branches have diverged and contain separate commits.

---

## What is a merge conflict?

A merge conflict happens when Git cannot automatically decide which changes to keep because the same part of a file was modified in different branches.

---

## Intentional Merge Conflict

### On main branch

```bash
echo "Version from main" > conflict.txt
git add .
git commit -m "Main version"
```

### On feature branch

```bash
git switch -c feature-conflict

echo "Version from feature branch" > conflict.txt
git add .
git commit -m "Feature version"
```

### Merge conflict

```bash
git switch main
git merge feature-conflict
```

Git showed a merge conflict because the same line was edited differently in both branches.

---

# Task 2: Git Rebase — Hands-On

## Create feature-dashboard branch

```bash
git switch -c feature-dashboard

echo "Dashboard UI" > dashboard.txt
git add .
git commit -m "Added dashboard UI"

echo "Dashboard API integration" >> dashboard.txt
git add .
git commit -m "Integrated dashboard API"
```

---

## Add commit on main

```bash
git switch main

echo "Main branch improvement" > improvement.txt
git add .
git commit -m "Improved main branch"
```

---

## Rebase feature-dashboard onto main

```bash
git switch feature-dashboard
git rebase main
```

---

## Visualize history

```bash
git log --oneline --graph --all
```

The history became cleaner and linear compared to merge history.

---

## What does rebase actually do to your commits?

Rebase moves or reapplies your commits on top of another branch as if they were created from the latest commit.

---

## How is history different from a merge?

| Merge | Rebase |
|---|---|
| Keeps branch history | Creates linear history |
| Adds merge commits | Rewrites commit history |
| Easier for collaboration | Cleaner commit timeline |

---

## Why should you never rebase shared commits?

Rebasing rewrites commit history and changes commit hashes. If commits were already pushed and shared, it can create confusion and conflicts for other developers.

---

## When would you use rebase vs merge?

- Use rebase for clean local history
- Use merge for shared/public branches

---

# Task 3: Squash Commit vs Merge Commit

## Create feature-profile branch

```bash
git switch -c feature-profile

echo "Profile page" > profile.txt
git add .
git commit -m "Added profile page"

echo "Typo fixed" >> profile.txt
git add .
git commit -m "Fixed typo"

echo "Formatting updated" >> profile.txt
git add .
git commit -m "Updated formatting"

echo "Validation added" >> profile.txt
git add .
git commit -m "Added validation"
```

---

## Squash merge into main

```bash
git switch main
git merge --squash feature-profile
git commit -m "Merged profile feature using squash"
```

---

## Check history

```bash
git log --oneline
```

Only one commit was added to `main`.

---

## Create feature-settings branch

```bash
git switch -c feature-settings

echo "Settings page" > settings.txt
git add .
git commit -m "Added settings page"

echo "Dark mode added" >> settings.txt
git add .
git commit -m "Added dark mode"
```

---

## Regular merge

```bash
git switch main
git merge feature-settings
```

This time all commits appeared separately in history.

---

## What does squash merging do?

Squash merge combines multiple commits into a single commit before merging into the target branch.

---

## When would you use squash merge vs regular merge?

- Squash merge → for cleaner history
- Regular merge → when detailed commit history matters

---

## What is the trade-off of squashing?

You lose detailed commit history from the feature branch.

---

# Task 4: Git Stash — Hands-On

## Make changes without committing

```bash
echo "Work in progress" > temp.txt
```

---

## Try switching branches

Git may prevent switching if changes conflict with another branch.

---

## Save work using stash

```bash
git stash
```

or with message:

```bash
git stash push -m "Temporary work"
```

---

## Switch branches and work

```bash
git switch feature-login
```

---

## Return and apply stash

```bash
git switch main
git stash pop
```

---

## Create multiple stashes

```bash
git stash push -m "First stash"
git stash push -m "Second stash"
```

---

## List all stashes

```bash
git stash list
```

---

## Apply a specific stash

```bash
git stash apply stash@{1}
```

---

## Difference between git stash pop and git stash apply

| git stash pop | git stash apply |
|---|---|
| Applies and removes stash | Applies without removing |
| Stash disappears after use | Stash remains saved |

---

## When would you use stash in real workflow?

Stash is useful when switching tasks quickly without committing unfinished work.

---

# Task 5: Cherry Picking

## Create feature-hotfix branch

```bash
git switch -c feature-hotfix

echo "Hotfix 1" > hotfix.txt
git add .
git commit -m "Hotfix commit 1"

echo "Critical bug fixed" >> hotfix.txt
git add .
git commit -m "Hotfix commit 2"

echo "Logging added" >> hotfix.txt
git add .
git commit -m "Hotfix commit 3"
```

---

## Switch to main

```bash
git switch main
```

---

## Find commit hash

```bash
git log --oneline
```

Example:

```bash
abc1234 Hotfix commit 2
```

---

## Cherry-pick second commit

```bash
git cherry-pick abc1234
```

---

## Verify history

```bash
git log --oneline
```

Only the selected commit appeared on `main`.

---

## What does cherry-pick do?

Cherry-pick applies a specific commit from one branch onto another branch.

---

## When would you use cherry-pick?

- Applying urgent fixes
- Moving a single feature commit
- Backporting bug fixes

---

## What can go wrong with cherry-picking?

- Duplicate commits
- Merge conflicts
- Confusing history if overused

---

# Commands Added to git-commands.md

```bash
git merge feature-login
git merge feature-signup

git rebase main

git log --oneline --graph --all

git merge --squash feature-profile

git stash
git stash push -m "message"
git stash pop
git stash apply stash@{1}
git stash list

git cherry-pick <commit-hash>
```

---

# Summary

Today I learned:

- Fast-forward merge vs merge commit
- Merge conflicts and conflict resolution
- Git rebase and clean history
- Squash merging
- Git stash workflow
- Cherry-picking specific commits
- Visualizing Git history using graph logs

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
