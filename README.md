# 🚀 My Personal Dotfiles

Welcome to my personal collection of dotfiles! This repository contains my shell configurations for `bash` and `zsh`, along with settings for various tools I use daily. The goal is to create a consistent and efficient development environment across different machines.

Feel free to explore, get inspired, or even fork this repository to create your own personalized setup.

[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## ✨ Features

- **Dual Shell Support:** Configurations for both `bash` and `zsh`.
- **Modular Structure:** Neatly organized into separate folders for easy management.
- **Customizable Prompts:** Colorful and informative shell prompts.
- **Helpful Aliases and Functions:** A collection of shortcuts and helper functions to speed up your workflow.
- **Vim Customization:** Personalized settings for a better user experience.
- **Automated Setup:** A simple setup script with sudo-less installation support to get you up and running quickly.
- **Periodic Update Checks:** Automatic checks for dotfiles updates every 14 days to keep your environment current.
- **macOS System Optimizations:** Pre-configured system defaults and keyboard shortcuts for a better development experience on macOS.
- **Cloud & Container Ready:** Out-of-the-box support for Google Project IDX and VS Code Devcontainers.
- **Code Quality:** Integrated pre-commit hooks and Conventional Commits enforcement.

## Getting Started

### Prerequisites

- None

### Installation

Getting started is easy! Just follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AlonsoFloo/dotfiles.git --recursive ~/dotfiles
   ```

1. **Run the setup script:**

   ```bash
   ~/dotfiles/setup.sh
   ```

   The setup script is interactive and will ask if you want to use `sudo` for certain installation steps. If you decline, it will skip those steps or attempt a sudo-less installation where possible.

And you're all set! The script will create the necessary symbolic links to get everything working.

### Untracked Configuration

The `untracked/` directory is intentionally left out of version control, making it the perfect place to store sensitive or machine-specific information, such as:

- **SSH configurations** with private host details.
- **Shell settings** with environment variables or secrets.

For example, you can create a `bashconfig` or `sshconfig` file inside the `untracked/` directory to define private aliases, functions, or SSH hosts. These files will be automatically sourced, so you can easily extend the dotfiles without committing personal data to the repository.

### Contribution setup (CONTRIBUTOR ONLY)

When working on this repository a few setup are required, you need to run:

```bash
pre-commit install
```

## 📂 Repository Structure

| Path                            | Description                                                                       |
| ------------------------------- | --------------------------------------------------------------------------------- |
| `.`                             | Repository root directory.                                                        |
| ├── 📂 `src/`                   | Main configuration files like `.zshrc` (`.bashrc`/`.bash_profile` linked), etc.   |
| │ ├── 📂 `agents/`              | Base configuration (`config.json`), system prompts, and APM skills for AI agents. |
| │ ├── 📂 `bash/`                | `bash`-specific configurations, including prompt, colors, and auto-completion.    |
| │ ├── 📂 `zsh/`                 | `zsh`-specific configurations, leveraging Oh My Zsh for plugins and themes.       |
| │ ├── 📂 `common/`              | Shared configurations between `bash` and `zsh` (aliases, functions, exports).     |
| │ ├── 📂 `config/`              | Configuration files for other applications (e.g., OpenCode).                      |
| │ ├── 📂 `vim/`                 | Vim-related files, such as color schemes.                                         |
| │ ├── 📂 `ssh/`                 | SSH client configuration.                                                         |
| │ └── 📂 `dircolors-solarized/` | Solarized color schemes for `ls`.                                                 |
| ├── 📂 `setup/`                 | Scripts for setting up the dotfiles on different operating systems.               |
| │ └── 📄 `Brewfile`             | List of Homebrew packages to install on macOS.                                    |
| ├── 📂 `untracked/`             | For private configurations, not tracked by Git (e.g., machine-specific settings). |
| └── 📄 `setup.sh`               | Main setup script located at the root for easy execution.                         |

## 💻 Tested Platforms

These dotfiles have been tested on the following platforms:

- macOS
- Linux (Ubuntu, Debian)
- Devcontainer (Debian Bullseye)
- Google Project IDX

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

[MIT](LICENSE)

## References

- OhMyZsh : [https://github.com/ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- ZSH syntax Highlighting : [https://github.com/zsh/zsh-syntax-highlighting](https://github.com/zsh/zsh-syntax-highlighting)
- Dircolor solarized : [https://github.com/seebi/dircolors-solarized](https://github.com/seebi/dircolors-solarized)

## TODO

- [] Rename the main branch to `main`
- [x] Move all dotfiles into a root folder `src` leaving repo handling separated.
  - Folder to be moved in `src`: `agents`, `bash`, `common`, `config`, `ssh`, `vim`, `zsh` (carefull, folder `zsh` contain git submodules that need to be moved with it)
  - File to be moved `src`: `bash_logout`, `bash_profile`, `bashrc`, `gitconfig`, `init`, `vim`, `inputrc`, `vimrc`, `zlogout`, `zshrc`
  - Submodule to be moved in `src`: `dircolor-solarized`
  - Updated all references of theses to use the new location
- [x] Move setup scripts into `setup` folder leaving repo handling separated (keep `setup.sh` at root for easy setup).
  - File to be moved `Brewfile`
  - Updated all references of theses to use the new location.
- [] Create workflow that tests changes
- [] Remove terminator configuration

______________________________________________________________________
