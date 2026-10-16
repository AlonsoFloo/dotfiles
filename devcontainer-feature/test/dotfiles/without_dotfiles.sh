#!/bin/bash
# Host without dotfiles: run with DOTFILES_GITCONFIG unset (mount falls back to /dev/null).
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

# Same include as with the dotfiles, to prove the empty fallback is harmless.
# shellcheck disable=SC2088 # literal ~, expanded by git as in the dotfiles gitconfig
git config --global include.path "~/dotfiles/untracked/gitconfig"

check "nothing forwarded" bash -c "[ ! -s ~/dotfiles/untracked/gitconfig ]"
check "git config still valid" git config --list
check "no git identity added" bash -c "[ -z \"\$(git config user.email)\" ]"
check "commit fails as on a bare host" bash -c "cd \"\$(mktemp -d)\" && git init -q && ! git -c user.useConfigOnly=true commit -q --allow-empty -m test"

reportResults
