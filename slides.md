# Introduction to GitHub Actions - Hands‑on Workshop
- Duration: 3.5 h
- Instructor:
- Repo & Codespace link
- Materials: notes.md (text/markdown)

---

## Goals & Outcomes
- Read and write workflows
- Run CI for Python projects
- Use matrix builds and multi‑OS testing
- Apply least‑privilege permissions
- Use artifacts, caching, and container jobs

---

## Logistics & Prerequisites
- GitHub account, basic git (clone/commit/push)
- Laptop with browser, VS Code (or editor)
- Codespaces recommended
- Starter repo with sample code and tests

---

## Workshop Flow & Pairing
- Mix of demos + hands‑on exercises
- Pairing encouraged
- Solution branch / cheat sheet available
- Break schedule

---

## Core Concepts (quick)
- Workflow: .github/workflows/*.yml
- Events: push, pull_request, schedule, etc.
- Jobs → Steps → Actions or run commands
- Runners (ubuntu/macos/windows/self-hosted)
- GITHUB_TOKEN and artifacts

---

## Demo: Create Your First Workflow
- .github/workflows/first_workflow.yml
- Example:
  name: My first GitHub workflow
  on: [push]
  jobs:
    greet:
      runs-on: ubuntu-latest
      steps:
        - run: echo "Hello world"
- Demo: create, commit, push, view Actions tab

---

## Exercise 1 - Create & Push First Workflow
- Create the first_workflow.yml in repo
- Commit and push
- Open Actions tab and inspect the run

---

## Anatomy of a Workflow File
- Top-level: name, on
- jobs: job-id: runs-on, steps
- steps: uses (action) vs run (shell)
- env, secrets, with, continue-on-error, timeout-minutes

---

## Exercise 2 - Add Steps & Environment
- Add env vars and multiple run steps
- Echo env and check logs per step

---

## Timeouts & Parallel Jobs
- timeout-minutes on jobs
- Jobs run in parallel by default
- Use needs: to enforce ordering

---

## Exercise 3 - Add Timeout & Second Job
- Add timeout-minutes to an existing job
- Add a second simple job to observe parallel runs

---

## Break (10 min)
- Short pause
- Instructor available for one-on-one help

---

## Running Your Code — Checkout & Setup
- actions/checkout to get repo
- actions/setup-python for Python versions
- Install deps and run tests (pip, pytest)

---

## Demo: Run Tests in Workflow
- run-code job:
  - uses: actions/checkout@v5
  - uses: actions/setup-python@v6 with python-version
  - run: pip install -r requirements-dev.txt
  - run: pytest
- Demo: live run against sample repo

---

## Exercise 4 - Implement CI Job
- Add run-code job to run tests for sample project
- Install dependencies and run pytest
- Inspect test output in Actions UI

---

## Inspecting Failures
- How failed steps appear in UI
- Logs per step, lines folded/expanded
- Re-run workflows, view failed traces

---

## Optional: Add a Failing Step (demo)
- Modify a test to fail, commit, push
- Observe failed workflow and logs
- Discuss debugging approach

---

## Permissions & Security Basics
- Default GITHUB_TOKEN has broad permissions
- Principle of least privilege: restrict permissions
- Set global: permissions: {} and job-level permissions: contents: read
- Pin actions to specific version or SHA

---

## Exercise 5 - Harden Permissions
- Add permissions: {} at top-level
- Add job permissions: contents: read where needed
- Re-run workflow and confirm functionality for public repo

---

## Matrix Builds (why & how)
- strategy.matrix expands jobs across values
- Example: matrix.python-version: [ "3.12","3.13","3.14" ]
- Use ${{ matrix.python-version }} in setup step
- fail-fast: false to run all combinations

---

## Demo: Matrix Example
- Show matrix for python-version and os
- Live demo: matrix expansion into multiple jobs in Actions UI

---

## Exercise 6 - Add a Matrix
- Add matrix to run-code job for two Python versions
- Re-run and inspect each matrix job

---

## Additional Operating Systems
- runners: ubuntu-latest, macos-latest, windows-latest
- Use matrix.os to test multiple OSes
- Be mindful of increased job count and minutes

---

## Conditionals
- Step-level: if: ${{ matrix.python-version == '3.14' }}
- Use single quotes around values in conditionals
- Useful for extra steps only on specific matrix values

---

## Job Dependencies
- needs: job-id — require job success before starting next
- Useful to run checks/lint before tests to save compute
- Example: run-code: needs: checks

---

## Exercise 7 - Conditionals & needs
- Add an extra step that runs only for Python 3.14
- Add a checks job and make run-code need it

---

## Actionlint
- Use actionlint to validate workflow YAML and suggest improvements
- actionlint playground: https://rhysd.github.io/actionlint/
- Demo: paste workflow and fix a lint warning

---

## Exercise 8 - Run Actionlint
- Validate your workflow in the actionlint playground
- Fix at least one lint warning and re-run workflow

---

## Artifacts & Caching
- Upload artifacts: actions/upload-artifact@v4
- Download artifacts between jobs: actions/download-artifact@v4
- Caching dependencies: actions/cache to speed CI

---

## Demo: Create & Upload Artifact
- Example steps:
  - run: echo "Hello world!" >> new_file.txt
  - uses: actions/upload-artifact@v4 with name/path
- Show artifact in Actions UI

---

## Exercise 9 - Upload an Artifact
- Add steps to create a file and upload as artifact
- Confirm artifact appears in the run UI

---

## Running Actions in a Docker Container
- container: image (Docker Hub or registry)
- Container jobs run on Linux runners only
- Example:
  container: python:3.14-slim
- Note: preinstalled runner software differs from hosted runner

---

## Exercise 10 - Container Job
- Convert a job to run in python:3.14-slim container
- Run a simple command to verify environment

---

## Pre-made Actions & Marketplace
- Browse marketplace for reusable actions
- Pin actions to a commit SHA for production
- Consider security implications when using third-party actions

---

## Optional Topics (overview)
- Billing and usage monitoring
- Security hardening of Actions
- Slack integration and notifications
- Workflow artifacts and sharing between jobs
- Self-hosted runners, CodeQL, Dependabot

---

## Creating Downloadable Artifacts (example)
- Steps:
  - run: echo "Hello world!" >> new_file.txt
  - uses: actions/upload-artifact@v4 with name/path/retention-days
- Shows how to persist and share build outputs or logs

---

## Running Jobs Inside Docker (example)
- jobs:
  container-job:
    runs-on: ubuntu-latest
    container: python:3.14-slim
- Reminder: differences in preinstalled software vs hosted runner

---

## Capstone Challenge
- Build a workflow that:
  - Triggers: push to main and pull_request targeting main
  - Has a checks (lint) job that must pass
  - Runs a run-code matrix for two Python versions
  - Uses minimal permissions
  - Uploads test logs as artifact
- 20-minute hands-on challenge

---

## Troubleshooting Tips & Common Gotchas
- YAML indentation and syntax errors
- Incorrect action versions or missing pins
- Cache key collisions
- Path issues and missing checkout
- Secret access and permissions problems

---

## Wrap-up & Next Steps
- Recap: workflows, jobs, matrix, permissions, artifacts
- Resources: notes.md (text/markdown), GitHub Actions docs, actionlint, Marketplace
- Provide solution branch with finished examples

---

## Q&A and Feedback
- Questions
- Feedback form link
- Instructor contact / follow-up resources

---

## Appendix: Instructor Notes (handout)
- Provide copy/paste snippets for each exercise in the starter repo
- Maintain a solution branch with completed workflows
- Encourage Codespaces to reduce local setup friction
- Monitor pace and be ready to shorten matrix or skip optional topics if participants fall behind

