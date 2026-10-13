#!/usr/bin/env bash
# Dev container Feature: forwards the host git and SSH config of these dotfiles.
# Runs as root at image build time and only wires git and ssh to stable paths
# under ${FORWARD_DIR}/active. link.sh fills them at container start, when the
# host untracked/ folder is mounted, or leaves them empty on a host without dotfiles.
# git ignores a missing include and ssh a missing Include, so empty is harmless.
set -euo pipefail

FORWARD_DIR="/usr/local/share/dotfiles-forward"
USERNAME="${_REMOTE_USER:-root}"

mkdir -p "${FORWARD_DIR}/active"
install -m 0755 "$(dirname "$0")/link.sh" "${FORWARD_DIR}/link.sh"
chown "${USERNAME}:" "${FORWARD_DIR}/active"

# Git identity at system level: survives anything rewriting ~/.gitconfig, and
# ~/.gitconfig (copied from the host by VS Code) still takes precedence.
# Written by hand when git is not installed yet (it may come later in the build).
if command -v git >/dev/null 2>&1; then
	git config --system --add include.path "${FORWARD_DIR}/active/gitconfig"
else
	printf '[include]\n\tpath = %s\n' "${FORWARD_DIR}/active/gitconfig" >>/etc/gitconfig
fi

# Private SSH hosts. Keys are never copied: ssh uses the agent VS Code forwards.
mkdir -p /etc/ssh/ssh_config.d
echo "Include ${FORWARD_DIR}/active/sshconfig" >/etc/ssh/ssh_config.d/dotfiles.conf
