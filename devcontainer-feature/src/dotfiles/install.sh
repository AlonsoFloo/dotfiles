#!/usr/bin/env bash
# Dev container Feature: forwards the host git and SSH config of these dotfiles.
# Runs as root at image build time. The host untracked/ folder is only mounted at
# runtime (falling back to /var/tmp on a host without dotfiles), so git and ssh
# include files from the mount by path. A missing file is ignored by both
# (git skips a missing include, ssh a missing Include), so nothing to do at start.
set -euo pipefail

UNTRACKED_MOUNT="/usr/local/share/dotfiles-untracked"

# Git identity at system level: survives anything rewriting ~/.gitconfig, and
# ~/.gitconfig (copied from the host by VS Code) still takes precedence.
# Written by hand when git is not installed yet (it may come later in the build).
if command -v git >/dev/null 2>&1; then
	git config --system --add include.path "${UNTRACKED_MOUNT}/gitconfig"
else
	printf '[include]\n\tpath = %s\n' "${UNTRACKED_MOUNT}/gitconfig" >>/etc/gitconfig
fi

# Private SSH hosts. Keys are never copied: ssh uses the agent VS Code forwards.
mkdir -p /etc/ssh/ssh_config.d
echo "Include ${UNTRACKED_MOUNT}/sshconfig" >/etc/ssh/ssh_config.d/dotfiles.conf
