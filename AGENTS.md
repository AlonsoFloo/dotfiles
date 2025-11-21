# Agent Instructions

This document provides instructions for AI agents working with this repository.

## Repository Overview

This is a personal dotfiles repository. It contains configurations for `bash`, `zsh`, and other tools, with a focus on creating a consistent and efficient development environment.

## 📦 Local development

### Requirements

- Pre-commit installed (handled automatically in Devcontainer)

### Run manually

```bash
source $DOTFILES/init
```

## Commits and Pull Requests

All commits and pull requests must follow the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) format. This is enforced by a pre-commit hook and a GitHub Actions workflow.

All pull requests must also follow the template defined in `.github/pull_request_template.md`.
