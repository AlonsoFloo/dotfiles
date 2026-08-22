#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( cd "$DIR/.." >/dev/null 2>&1 && pwd )"

echo "Building test Docker container..."
docker build -t dotfiles-test -f "$DIR/Dockerfile" "$REPO_ROOT"

echo "Running dotfiles automated test suite in Docker container..."
docker run --rm dotfiles-test
