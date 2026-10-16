#!/bin/bash
# Host has dotfiles: run with DOTFILES_GITCONFIG pointing at fixtures/gitconfig.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

# What VS Code copies from a host using the dotfiles: ~/.gitconfig including the file.
# shellcheck disable=SC2088 # literal ~, expanded by git as in the dotfiles gitconfig
git config --global include.path "~/dotfiles/untracked/gitconfig"

check "host gitconfig available at the same path" grep -q "Feature Test" ~/dotfiles/untracked/gitconfig
check "only the gitconfig is mounted" bash -c "[ \"\$(grep -c dotfiles /proc/self/mountinfo)\" = 1 ]"
check "git identity name" bash -c "[ \"\$(git config user.name)\" = 'Feature Test' ]"
check "git identity email" bash -c "[ \"\$(git config user.email)\" = 'feature-test@example.com' ]"
check "commit uses the identity" bash -c "cd \"\$(mktemp -d)\" && git init -q && git commit -q --allow-empty -m test && [ \"\$(git log -1 --format=%ae)\" = 'feature-test@example.com' ]"
check "unused without the include" bash -c "[ -z \"\$(HOME=\$(mktemp -d) git config user.email)\" ]"

reportResults
