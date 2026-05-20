# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

# Task 1: Install and Authenticate

## Install GitHub CLI

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install gh
```

### macOS

```bash
brew install gh
```

### Windows

```bash
winget install --id GitHub.cli
```

---

## Authenticate with GitHub

```bash
gh auth login
```

Selected options:

- GitHub.com
- HTTPS
- Login with browser

---

## Verify Login

```bash
gh auth status
```

This displayed the active GitHub account and authentication status.

---

## What authentication methods does gh support?

GitHub CLI supports:

- Browser-based authentication
- Personal Access Token (PAT)
- SSH authentication
- GitHub Enterprise authentication

---

# Task 2: Working with Repositories

## Create a new repo from terminal

```bash
gh repo create devops-gh-cli-practice --public --clone --add-readme
```

---

## Clone a repo using gh

```bash
gh repo clone cli/cli
```

---

## View repo details

```bash
gh repo view
```

or

```bash
gh repo view owner/repo
```

---

## List all repositories

```bash
gh repo list
```

---

## Open repo in browser

```bash
gh repo view --web
```

---

## Delete repository

```bash
gh repo delete devops-gh-cli-practice
```

GitHub CLI asked for confirmation before deleting the repository.

---

# Task 3: Issues

## Create issue from terminal

```bash
gh issue create \
--title "Fix login validation bug" \
--body "Validation is not working correctly on login page" \
--label "bug"
```

---

## List open issues

```bash
gh issue list
```

---

## View specific issue

```bash
gh issue view 1
```

---

## Close issue

```bash
gh issue close 1
```

---

## How could gh issue be useful in automation?

`gh issue` can be used in scripts to:

- Automatically create bug reports
- Track deployment failures
- Generate issues from monitoring alerts
- Manage CI/CD notifications

---

# Task 4: Pull Requests

## Create branch and push changes

```bash
git switch -c feature-gh-cli

echo "GitHub CLI practice" > gh-cli.txt
git add .
git commit -m "Added GitHub CLI notes"

git push -u origin feature-gh-cli
```

---

## Create PR from terminal

```bash
gh pr create --fill
```

This automatically filled PR title and body using commit message.

---

## List open PRs

```bash
gh pr list
```

---

## View PR details

```bash
gh pr view
```

or detailed JSON output:

```bash
gh pr view --json statusCheckRollup,reviewRequests
```

---

## Merge PR from terminal

```bash
gh pr merge
```

---

## What merge methods does gh pr merge support?

GitHub CLI supports:

- Merge commit
- Squash merge
- Rebase merge

Examples:

```bash
gh pr merge --merge
gh pr merge --squash
gh pr merge --rebase
```

---

## How would you review someone else's PR using gh?

```bash
gh pr checkout <pr-number>
```

Then test changes locally and review:

```bash
gh pr review <pr-number> --approve
```

or request changes:

```bash
gh pr review <pr-number> --request-changes --body "Fix issue"
```

---

# Task 5: GitHub Actions & Workflows

## List workflow runs

```bash
gh run list
```

---

## View workflow run details

```bash
gh run view <run-id>
```

---

## How could gh run and gh workflow help in CI/CD?

They help DevOps engineers:

- Monitor CI/CD pipelines
- Debug failed workflows
- Restart failed jobs
- Trigger workflows from scripts
- Automate deployment monitoring

---

# Task 6: Useful gh Tricks

# gh api

## Make GitHub API calls

```bash
gh api user
```

Useful for automation and scripting.

---

# gh gist

## Create gist from terminal

```bash
gh gist create notes.txt
```

---

# gh release

## Create release

```bash
gh release create v1.0.0
```

---

# gh alias

## Create shortcut command

```bash
gh alias set prs "pr list"
```

Now:

```bash
gh prs
```

---

# gh search repos

## Search repositories

```bash
gh search repos kubernetes
```

---

# Commands Added to git-commands.md

# GitHub CLI Authentication

```bash
gh auth login
gh auth status
gh auth logout
```

---

# Repository Commands

```bash
gh repo create repo-name --public --clone --add-readme
gh repo clone owner/repo
gh repo list
gh repo view
gh repo view --web
gh repo delete repo-name
```

---

# Issue Commands

```bash
gh issue create
gh issue list
gh issue view <issue-number>
gh issue close <issue-number>
```

---

# Pull Request Commands

```bash
gh pr create --fill
gh pr list
gh pr view
gh pr merge
gh pr checkout <pr-number>
gh pr review <pr-number> --approve
```

---

# Workflow Commands

```bash
gh run list
gh run view <run-id>
```

---

# Utility Commands

```bash
gh api user
gh gist create file.txt
gh release create v1.0.0
gh alias set prs "pr list"
gh search repos kubernetes
```

---

# Summary

Today I learned:

- Installing and authenticating GitHub CLI
- Managing repositories from terminal
- Creating and managing issues
- Creating pull requests without browser
- Monitoring GitHub Actions workflows
- Using GitHub API through terminal
- Automating GitHub operations using gh

GitHub CLI makes development and DevOps workflows much faster because everything can be managed directly from the terminal.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
