#!/bin/bash
# Default scenario: minimal image (no git, no ssh), host without dotfiles.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "git include configured" grep -q "dotfiles-untracked/gitconfig" /etc/gitconfig
check "ssh include configured" grep -q "dotfiles-untracked/sshconfig" /etc/ssh/ssh_config.d/dotfiles.conf
check "no host gitconfig" test ! -e /usr/local/share/dotfiles-untracked/gitconfig

reportResults
