#!/usr/bin/env bash
# Dev container Feature: forwards the host git and SSH config of these dotfiles.
# Runs as root at image build time. The host ~/dotfiles/untracked is bind mounted
# at runtime only, so everything below points at the mount and resolves on start.
# Missing files are fine: git ignores a missing include and ssh a missing Include.
set -euo pipefail

UNTRACKED_MOUNT="/usr/local/share/dotfiles-untracked"
USERNAME="${_REMOTE_USER:-root}"
USER_HOME="${_REMOTE_USER_HOME:-$(getent passwd "${USERNAME}" | cut -d: -f6)}"

# 1. Git identity. System level so it survives anything rewriting ~/.gitconfig;
#    ~/.gitconfig (copied from the host by VS Code) still takes precedence.
git config --system --add include.path "${UNTRACKED_MOUNT}/gitconfig"

# 2. Same path as on the host, so the `[include] path = ~/dotfiles/untracked/gitconfig`
#    of the copied ~/.gitconfig and the `Include ~/dotfiles/untracked/sshconfig`
#    of the dotfiles SSH config resolve too.
mkdir -p "${USER_HOME}/dotfiles"
ln -sfn "${UNTRACKED_MOUNT}" "${USER_HOME}/dotfiles/untracked"
chown -h "${USERNAME}:" "${USER_HOME}/dotfiles" "${USER_HOME}/dotfiles/untracked"

# 3. Private SSH hosts. Keys are never copied: ssh uses the agent VS Code forwards.
mkdir -p /etc/ssh/ssh_config.d
echo "Include ${UNTRACKED_MOUNT}/sshconfig" >/etc/ssh/ssh_config.d/dotfiles.conf

# 4. GitHub SSH host keys (https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)
known_hosts="/etc/ssh/ssh_known_hosts"
if ! grep -qs "^github.com ssh-ed25519 " "${known_hosts}"; then
	cat >>"${known_hosts}" <<'KEYS'
github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
KEYS
fi

echo "Dotfiles git and SSH forwarding configured for ${USERNAME}"
