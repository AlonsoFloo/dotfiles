# AlonsoFloo dotfiles forwarding (dotfiles)

When the host uses these dotfiles, forwards their git identity and SSH config into any dev container, so commit and push work as on the host. It does not install the dotfiles in the container.

## Usage

Add it to every container you build, in your VS Code **user** settings:

```json
"dev.containers.defaultFeatures": {
  "ghcr.io/alonsofloo/dotfiles/dotfiles:1": {}
}
```

## What it does

The dotfiles keep private settings in `~/dotfiles/untracked` (`gitconfig` with `[user]`, `sshconfig`), which VS Code does not bring into the container. The Feature:

- bind mounts the host `~/dotfiles/untracked` to `/usr/local/share/dotfiles-untracked`;
- includes its `gitconfig` from `/etc/gitconfig`, so the git identity is set even if `~/.gitconfig` changes;
- links it to `~/dotfiles/untracked` in the container, so the `[include]` of the `~/.gitconfig` copied by VS Code resolves as on the host;
- includes its `sshconfig` from `/etc/ssh/ssh_config.d/dotfiles.conf` for private SSH hosts;
- pins GitHub SSH host keys in `/etc/ssh/ssh_known_hosts`.

Private keys are never copied: SSH uses the agent VS Code forwards from the host. Missing `gitconfig` or `sshconfig` files are ignored.

## Requirements

- The host must have `~/dotfiles/untracked` (it exists in any clone of this repository), otherwise Docker refuses the bind mount and the container is not created.
- Your SSH key loaded in the host agent: `ssh-add -l` (on macOS `ssh-add --apple-use-keychain ~/.ssh/<key>`).
