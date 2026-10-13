# AlonsoFloo dotfiles (dotfiles)

Installs these dotfiles in any dev container, for the container user, without touching the project's `devcontainer.json`.

## Usage

Add it to every container you build, in your VS Code **user** settings:

```json
"dev.containers.defaultFeatures": {
  "ghcr.io/alonsofloo/dotfiles/dotfiles:1": {}
}
```

and remove `dotfiles.repository` if it is set, so the dotfiles are not installed twice.

## What it does

- Clones the dotfiles with their submodules (Oh My Zsh, zsh-syntax-highlighting, dircolors) into `~/dotfiles` and runs `setup.sh --quiet`, without sudo.
- Bind mounts the host `~/dotfiles/untracked` to `/usr/local/share/dotfiles-untracked` and links `gitconfig`, `sshconfig` and `bashconfig` from it, so the git identity and private SSH hosts are the same as on the host. Private keys are never copied: SSH uses the agent forwarded by VS Code.
- Sets the login shell (`zsh` by default) and pins GitHub SSH host keys in `/etc/ssh/ssh_known_hosts`.

## Options

| Option         | Default                                      | Description                                           |
| -------------- | -------------------------------------------- | ----------------------------------------------------- |
| `repository`   | `https://github.com/AlonsoFloo/dotfiles.git` | Dotfiles repository to clone.                         |
| `branch`       | `master`                                     | Branch to clone.                                      |
| `defaultShell` | `zsh`                                        | Login shell for the container user (`zsh` or `bash`). |

## Requirements

- The host must have `~/dotfiles/untracked` (it exists in any clone of this repository), otherwise Docker refuses the bind mount and the container is not created.
- Debian or Ubuntu based image if `git` or `zsh` are missing.
- Load your SSH key in the host agent (`ssh-add -l`; on macOS `ssh-add --apple-use-keychain ~/.ssh/<key>`).
