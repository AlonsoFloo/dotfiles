#!/bin/bash
# Host has dotfiles: run with DOTFILES_UNTRACKED pointing at fixtures/untracked.
set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "host gitconfig is forwarded" test -L /usr/local/share/dotfiles-forward/active/gitconfig
check "git identity name" bash -c "[ \"\$(git config user.name)\" = 'Feature Test' ]"
check "git identity email" bash -c "[ \"\$(git config user.email)\" = 'feature-test@example.com' ]"
check "commit uses the identity" bash -c "cd \"\$(mktemp -d)\" && git init -q && git commit -q --allow-empty -m test && [ \"\$(git log -1 --format=%ae)\" = 'feature-test@example.com' ]"
check "private ssh host resolved" bash -c "ssh -G homelab | grep -qx 'hostname 192.168.1.10'"

reportResults
