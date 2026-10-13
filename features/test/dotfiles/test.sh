#!/bin/bash
# Default scenario: minimal image (no git, no ssh), host without dotfiles.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "link script installed" test -x /usr/local/share/dotfiles-forward/link.sh
check "git include configured" grep -q "dotfiles-forward/active/gitconfig" /etc/gitconfig
check "ssh include configured" grep -q "dotfiles-forward/active/sshconfig" /etc/ssh/ssh_config.d/dotfiles.conf
check "no forwarded gitconfig" test ! -e /usr/local/share/dotfiles-forward/active/gitconfig
check "no forwarded sshconfig" test ! -e /usr/local/share/dotfiles-forward/active/sshconfig

reportResults
