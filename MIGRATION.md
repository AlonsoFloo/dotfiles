# 🔄 Migration Guide

This guide outlines the steps required to migrate an existing local dotfiles installation to the new repository structure (`src/`, root `setup.sh`, and root `untracked/`).

## Key Changes

1. Dotfiles configurations are now located in `~/dotfiles/src/`.
1. `setup.sh` is located at the root of the repository (`~/dotfiles/setup.sh`).
1. `untracked/` remains at the root of the repository (`~/dotfiles/untracked/`).
1. Git submodules have been moved under `src/` (`src/dircolors-solarized`, `src/zsh/oh-my-zsh`, `src/zsh/zsh-syntax-highlighting`).
1. `.bashrc` and `.bash_profile` in `src/` are symbolic links pointing to `src/zshrc`.
1. `zshrc` exports both `DOTFILES_REPO=$HOME/dotfiles` and `DOTFILES=$HOME/dotfiles/src`.

## Migration Steps on an Existing Machine

Run the following commands in your terminal:

1. **Pull the latest changes and update git submodules:**

   ```bash
   cd ~/dotfiles
   git pull origin master
   git submodule sync --recursive
   git submodule update --init --recursive
   ```

1. **Move any untracked configurations to the root `untracked/` directory if needed:**

   ```bash
   mkdir -p ~/dotfiles/untracked
   # If you had untracked configs inside src/untracked or dotfiles/untracked:
   mv ~/dotfiles/src/untracked/* ~/dotfiles/untracked/ 2>/dev/null || true
   ```

1. **Re-run the setup script to refresh all home directory symlinks and backups:**

   ```bash
   ~/dotfiles/setup.sh
   ```

1. **Reload your shell configuration:**

   ```bash
   source ~/.zshrc   # for zsh
   # or
   source ~/.bashrc  # for bash
   ```
