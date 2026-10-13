#!/usr/bin/env bash
# Dev container Feature: installs these dotfiles for the container's remote user.
# Runs as root at image build time; the host ~/dotfiles/untracked is only
# mounted at runtime, so its files are linked here and resolve once started.
set -euo pipefail

REPOSITORY="${REPOSITORY:-https://github.com/AlonsoFloo/dotfiles.git}"
BRANCH="${BRANCH:-master}"
DEFAULTSHELL="${DEFAULTSHELL:-zsh}"

USERNAME="${_REMOTE_USER:-root}"
USER_HOME="${_REMOTE_USER_HOME:-$(getent passwd "${USERNAME}" | cut -d: -f6)}"
TARGET="${USER_HOME}/dotfiles"
UNTRACKED_MOUNT="/usr/local/share/dotfiles-untracked"

# Packages the dotfiles rely on
missing_packages=()
for package in git zsh; do
	command -v "${package}" >/dev/null 2>&1 || missing_packages+=("${package}")
done
if [[ ${#missing_packages[@]} -gt 0 ]]; then
	if ! command -v apt-get >/dev/null 2>&1; then
		echo "(!) Missing ${missing_packages[*]} and apt-get is not available" >&2
		exit 1
	fi
	apt-get update -qq
	DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends ca-certificates "${missing_packages[@]}"
	rm -rf /var/lib/apt/lists/*
fi

# Clone with submodules (oh-my-zsh, zsh-syntax-highlighting, dircolors)
rm -rf "${TARGET}"
git clone --depth 1 --branch "${BRANCH}" --recurse-submodules --shallow-submodules "${REPOSITORY}" "${TARGET}"

# Private host files (gitconfig identity, sshconfig, bashconfig), resolved at runtime
for file in gitconfig sshconfig bashconfig; do
	ln -sfn "${UNTRACKED_MOUNT}/${file}" "${TARGET}/untracked/${file}"
done

chown -R "${USERNAME}:" "${TARGET}"

# Link the dotfiles as the user, without sudo and without the interactive prompt
su "${USERNAME}" -s /bin/bash -c "cd '${TARGET}' && USE_SUDO_PROMPTED=yes USE_SUDO=no ./setup.sh --quiet"

# A fresh install is up to date: do not ask to update on the first shell
echo "$(($(date +%s) / 60 / 60 / 24))" >"${USER_HOME}/.dotfiles-update"
chown "${USERNAME}:" "${USER_HOME}/.dotfiles-update"

# Login shell
shell_path="$(command -v "${DEFAULTSHELL}")"
chsh -s "${shell_path}" "${USERNAME}"

# GitHub SSH host keys (https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)
known_hosts="/etc/ssh/ssh_known_hosts"
mkdir -p "$(dirname "${known_hosts}")"
if ! grep -qs "^github.com ssh-ed25519 " "${known_hosts}"; then
	cat >>"${known_hosts}" <<'KEYS'
github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
KEYS
fi

echo "Dotfiles installed in ${TARGET} for ${USERNAME}"
