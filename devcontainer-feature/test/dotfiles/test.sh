#!/bin/bash
# Default scenario: minimal image (no git), host without dotfiles.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "host path linked to the mount" bash -c "[ \"\$(readlink ~/dotfiles/untracked/gitconfig)\" = /usr/local/share/dotfiles/gitconfig ]"
check "nothing forwarded" bash -c "[ ! -s ~/dotfiles/untracked/gitconfig ]"
check "only the gitconfig is created" bash -c "[ \"\$(ls -A ~/dotfiles)\" = untracked ] && [ \"\$(ls -A ~/dotfiles/untracked)\" = gitconfig ]"
check "system git config untouched" test ! -e /etc/gitconfig
check "ssh config untouched" test ! -e /etc/ssh/ssh_config.d/dotfiles.conf

reportResults
