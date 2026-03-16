---
geometry: left=2cm,right=2cm,top=2cm,bottom=2cm
disable-header-and-footer: true
colorlinks: true
pdf-engine: lualatex
---

# Introduction to GitHub Actions - Exercises

## Exercise 0: Initial Setup

-   Create a fork or copy of the workshop repository into your own GitHub account
    [TBD](LINK)

    The repository should be `public`.

-   If you made a fork: Go to the settings of the fork and allow GitHub Actions
to run on this fork

-   Depending on how you want to work with the repository
    -   Clone the repository to your laptop
    -   Create a GitHub Codespace on the `main` branch

## Exercise 1: Create Your First Workflow

Goal: Add a new workflow to the repository and inspect its output on the
repository's website.

-   Create a new folder `.github/workflows/`

-   Create new workflow file `touch exercise1_workflow.yml` inside the `workflows/`
directory with the following content

    ```yaml
    name: My first GitHub workflow
    run-name: First workflow # Optional

    # Events triggering the workflow
    on: [push]

    # Group of jobs to run as part of the workflow
    jobs:
      greet:
        runs-on: ubuntu-latest
        steps:
          - run: echo "Hello world"
    ```

-   Add file to repository, commit, and push the changes to the `main` branch

    In case you use a terminal:

    ```bash
    git add exercise1_workflow.yml
    git commit -m "Add exercise 1 workflow"
    git push
    ```

-   Go to `Actions` tab of your repository.

    The workflow should run on GitHub (maybe is already finished).

-   Inspect the output. There should be three steps

    1. `Set up job`
    2. `Run echo "Hello world"`
    3. `Complete job`

    Steps 1 and 2 are implicitly added by GitHub.

-   Optional: Add/remove the `run-name`, commit & push the change and check how
this influences the name of the workflow on the GitHub website.

## Exercise 2: Multi-job workflows and failing jobs

Goal: Setting up a workflow with different runners, dependencies and inspecting
failing jobs.

-   Create a new branch `exercise2` and change to this branch, e.g., via `git
checkout -b exercise2`
-   Create a new workflow `exercise2_workflow.yml`.
-   This workflow should run on the following events:
    -   `push` to `main` branch
    -   `pull_request` to `main` branch
    -   `workflow_dispatch`
-   The workflow should contain five jobs

    1. `ubuntu_job` that runs on `ubuntu-latest` and prints `Hello, I'm ubuntu-latest`
    2. `macos_job` that runs on `macos-latest` and prints `Hello, I'm macos-latest`
    3. `slow_job` that runs on `ubuntu-latest`, prints `Hello, I'm slow_job`
       and then sleeps for 2 minutes (120 seconds) and has a timeout of **1
    minute**.
    4. `waiting_job` that runs on `ubuntu-latest`. It depends on `slow_job` and
       runs the command `ls -l`. This prints all files in the current directory.

-   Add the new workflow to git, commit it and push it to GitHub.

-   Check the Actions panel on GitHub and verify that the job did **not** run.

-   Use your branch to open a pull request targetting main. Check which
workflows are running. Only, the workflow of the first exercise should be
running.

-   Merge your PR and inspect the Actions panel again. Your new workflow should
be running. Inspect the output and verify that the `waiting_job` fails. Inspect
the output of the failing job (`slow_job`). It should give you a hint why it is
failing. The job `waiting_job` should not have started.

-   Reduce the sleeping time of `slow_job` to 45 seconds and its timeout to 5
minutes. Push the changes to your repository. If you add the changes via a pull
request, you should see that your newly added jobs are running. All jobs should
run successfully and you should be able to see that `waiting_job` still waits
for `slow_job`.

-   Go to the Actions panel in your repository and manually start you workflow.

-   Check the output of `waiting_job` carefully. What files are being listed?

\newpage

## Exercise 3: Matrix builds and conditionals

Goal: Setting up a workflow with different operating systems using GitHub's
matrix builds while using predefined actions. Use `actionlint` to find mistakes
early.

There is some very simple Python code in the repository, see `mycode.py`, that
comes with some simple tests, see `test_mycode.py`.

-   Create a new workflow `exercise3_workflow.yml`

-   Carry out several tasks

    1. Update pip and install the dependencies needed by the Python code`
       ```text
       python -m pip install --upgrade pip
       python -m pip install -r requirements-dev.txt
       ```

    2. Add a step that checks the style of the code
        ```text
        python -m black mycode
        ```
    3. Run the test by running
        ```text
        python -m pytest test_mycode.py
        ```

-   The tests should be run on `windows-latest`, `macos-latest`, and
    `ubuntu-latest`.

-   The tests should be run on Python version `3.12`, `3.13`, and `3.14`.

-   Use `actionlint` to check your workflow file for correctness. If you don't
    make mistaked, introduce some explicit errors to see how the actionlint
    output looks like.

\newpage

## Exercise ??: Security

-   Enable CodeQL in the repository settings

-   Check the Actions section in the repository. CodeQL should run as an
    Action/workflow.

-   After the workflow finishes, you should see some warnings in the Security
    panel of the repository.

-   Add explicit permission to your workflows. Start with dropping all
    permissions and check if the wofklow still succeeds. Only add permissions
    if necessary.

-   Verify that the security warning disappear.

\newpage

## Exercise ??: Creating artifacts and using Docker

Goal: Create downloadable PDFs of the workshop notes.

-   The can be converted to a PDF via the following command

    ```text
    pandoc --template eisvogel notes.md -o notes.pdf
    ```

-   Optional: Create a downloadable version of the slides. The slides can be
    converted to a PDF via the following command

    ```text
    pandoc -t beamer slides.md  -o  slides.pdf
    ```

## Exercise ??

- Docs [asdf](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#push)
