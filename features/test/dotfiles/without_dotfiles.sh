#!/bin/bash
# Host without dotfiles: run with DOTFILES_UNTRACKED unset.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "no forwarded gitconfig" test ! -e /usr/local/share/dotfiles-forward/active/gitconfig
check "no forwarded sshconfig" test ! -e /usr/local/share/dotfiles-forward/active/sshconfig
check "git still works" git --version
check "no git identity added" bash -c "[ -z \"\$(git config user.email)\" ]"
check "ssh config still valid" bash -c "ssh -G github.com >/dev/null"

reportResults
