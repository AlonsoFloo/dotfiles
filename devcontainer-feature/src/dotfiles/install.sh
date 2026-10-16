#!/usr/bin/env bash
# Dev container Feature: makes the host ~/dotfiles/untracked/gitconfig available
# at the same path in the container, and nothing else.
# The file itself is bind mounted at runtime on GITCONFIG_MOUNT (/dev/null, an
# empty config, when the host has no dotfiles). It is only used when the
# ~/.gitconfig VS Code copies from the host includes it, as the dotfiles one does.
set -euo pipefail

GITCONFIG_MOUNT="/usr/local/share/dotfiles/gitconfig"
USER_HOME="${_REMOTE_USER_HOME:-$HOME}"

mkdir -p "${USER_HOME}/dotfiles/untracked"
ln -sf "${GITCONFIG_MOUNT}" "${USER_HOME}/dotfiles/untracked/gitconfig"
chown -R "${_REMOTE_USER:-root}:" "${USER_HOME}/dotfiles"
