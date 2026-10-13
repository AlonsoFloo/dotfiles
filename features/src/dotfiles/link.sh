#!/usr/bin/env bash
# Runs at every container start (postStartCommand) as the remote user.
# Links the host untracked/ files that exist into place. On a host without
# dotfiles, DOTFILES_UNTRACKED is unset, the mount falls back to /var/tmp,
# which has no gitconfig/sshconfig, so nothing is forwarded.
set -euo pipefail

FORWARD_DIR="/usr/local/share/dotfiles-forward"

forwarded=()
for file in gitconfig sshconfig; do
	rm -f "${FORWARD_DIR}/active/${file}"
	if [[ -f "${FORWARD_DIR}/host/${file}" ]]; then
		ln -s "${FORWARD_DIR}/host/${file}" "${FORWARD_DIR}/active/${file}"
		forwarded+=("${file}")
	fi
done

if [[ ${#forwarded[@]} -eq 0 ]]; then
	echo "dotfiles-forward: no host dotfiles found, nothing forwarded"
else
	echo "dotfiles-forward: forwarded ${forwarded[*]}"
fi
