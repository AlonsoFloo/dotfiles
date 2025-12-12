# 🚀 My Personal Dotfiles

Welcome to my personal collection of dotfiles! This repository contains my shell configurations for `bash` and `zsh`, along with settings for various tools I use daily. The goal is to create a consistent and efficient development environment across different machines.

Feel free to explore, get inspired, or even fork this repository to create your own personalized setup.

______________________________________________________________________

## ✨ Features

- **Dual Shell Support:** Configurations for both `bash` and `zsh`.
- **Modular Structure:** Neatly organized into separate folders for easy management.
- **Customizable Prompts:** Colorful and informative shell prompts.
- **Helpful Aliases and Functions:** A collection of shortcuts and helper functions to speed up your workflow.
- **Vim and Terminator Customization:** Personalized settings for a better user experience.
- **Automated Setup:** A simple setup script to get you up and running quickly.

______________________________________________________________________

## 📂 Folder Structure

Here's a breakdown of the repository's structure:

| Path                    | Description                                                                       |
| ----------------------- | --------------------------------------------------------------------------------- |
| `.`                     | Main configuration files like `.bash_profile`, `.zshrc`, `.vimrc`, etc.           |
| ├── 📂 `.devcontainer/` | Configuration for Visual Studio Code Devcontainers.                               |
| ├── 📂 `bash/`          | `bash`-specific configurations, including prompt, colors, and auto-completion.    |
| ├── 📂 `zsh/`           | `zsh`-specific configurations, leveraging Oh My Zsh for plugins and themes.       |
| ├── 📂 `common/`        | Shared configurations between `bash` and `zsh` (aliases, functions, exports).     |
| ├── 📂 `config/`        | Configuration files for other applications (e.g., Terminator).                    |
| ├── 📂 `vim/`           | Vim-related files, such as color schemes.                                         |
| ├── 📂 `setup/`         | Scripts for setting up the dotfiles on different operating systems.               |
| ├── 📂 `ssh/`           | SSH client configuration.                                                         |
| ├── 📂 `untracked/`     | For private configurations, not tracked by Git (e.g., machine-specific settings). |

______________________________________________________________________

## 🔒 Untracked Configuration

The `untracked/` directory is intentionally left out of version control, making it the perfect place to store sensitive or machine-specific information, such as:

- **SSH configurations** with private host details.
- **Shell settings** with environment variables or secrets.

For example, you can create a `bashconfig` or `sshconfig` file inside the `untracked/` directory to define private aliases, functions, or SSH hosts. These files will be automatically sourced, so you can easily extend the dotfiles without committing personal data to the repository.

______________________________________________________________________

## ⚙️ Installation

### Standard

Getting started is easy! Just follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AlonsoFloo/dotfiles.git --recursive ~/dotfiles
   ```

1. **Run the setup script:**

   ```bash
   ~/dotfiles/setup.sh
   ```

And you're all set! The script will create the necessary symbolic links to get everything working.

### Custom

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AlonsoFloo/dotfiles.git --recursive
   ```

1. **Then you need to edit theses files and set the correct path of your dotfiles directory**

   - setup.sh
   - bashrc
   - bash_profile
   - zshrc

## pre-commit Hooks

This repository uses `pre-commit` to enforce code quality and consistency. The pre-commit hooks are configured in the `.pre-commit-config.yaml` file and are run automatically before each commit.

To use the pre-commit hooks, you need to install `pre-commit` on your local
machine. The setup script will do this for you, but if you need to do it
manually, you can use Homebrew on macOS:

```bash
brew install pre-commit
```

Once `pre-commit` is installed, you need to install the git hooks:

```bash
pre-commit install
```

Now, the pre-commit hooks will run automatically every time you make a commit.

______________________________________________________________________

## 💻 Supported Platforms

These dotfiles have been tested on the following operating systems:

- Ubuntu 14.04
- Kubuntu 14.04
- macOS
- Devcontainer (Debian Bullseye)

______________________________________________________________________

## 🤝 Contributing

Pull requests are welcome! If you have any improvements or suggestions, feel free to submit a pull request. However, please ensure that your contributions do not contain any personal or sensitive data.
