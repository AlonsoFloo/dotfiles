#!/bin/bash
# Host without dotfiles: run with DOTFILES_UNTRACKED unset (mount falls back to /var/tmp).
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "no host gitconfig" test ! -e /usr/local/share/dotfiles-untracked/gitconfig
check "git still works" git --version
check "no git identity added" bash -c "[ -z \"\$(git config user.email)\" ]"
check "ssh config still valid" bash -c "ssh -G github.com >/dev/null"

reportResults
