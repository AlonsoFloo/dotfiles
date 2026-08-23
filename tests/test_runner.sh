#!/bin/bash
set -e

echo "=== 1. Setting up test environment (git clone simulation to ~/dotfiles) ==="
DOTFILES_SRC="${DOTFILES_SRC:-/tmp/dotfiles-src}"
TEST_TEMP_HOME=$(mktemp -d)
export HOME="$TEST_TEMP_HOME"
mkdir -p "$HOME/dotfiles"

if [ -d "$DOTFILES_SRC" ]; then
    cp -a "$DOTFILES_SRC/." "$HOME/dotfiles/"
else
    cp -a "$(pwd)/." "$HOME/dotfiles/"
fi
cd "$HOME/dotfiles"

echo "=== 2. Testing setup.sh --quiet with pre-existing file and symlink backup ==="
# Create pre-existing file and symlink in ~ to test .dotfiles.bak content copy
echo "dummy_content" > "$HOME/dummy_target.txt"
ln -sf "$HOME/dummy_target.txt" "$HOME/.bashrc"
echo "custom_vimrc" > "$HOME/.vimrc"

~/dotfiles/setup.sh --quiet

if [ ! -f "$HOME/.bashrc.dotfiles.bak" ] || [ "$(cat "$HOME/.bashrc.dotfiles.bak")" != "dummy_content" ]; then
    echo "Backup of symlink .bashrc failed or did not copy actual file content!"
    exit 1
fi

if [ ! -f "$HOME/.vimrc.dotfiles.bak" ] || [ "$(cat "$HOME/.vimrc.dotfiles.bak")" != "custom_vimrc" ]; then
    echo "Backup of file .vimrc failed or did not copy actual content!"
    exit 1
fi
echo "[OK] Symlink and file content backup to .dotfiles.bak verified."

echo "=== 3. Testing Linux setup and verifying macOS setup files presence ==="
test -f ~/dotfiles/setup/linux.sh || { echo "Linux setup script missing!"; exit 1; }
test -f ~/dotfiles/setup/ios.sh || { echo "macOS setup script missing!"; exit 1; }
test -f ~/dotfiles/setup/Brewfile || { echo "Brewfile missing!"; exit 1; }
echo "[OK] Setup files check passed."

echo "=== 4. Testing ~ home directory symlinks ==="
SYMLINKS=(
    "bash_logout"
    "bashrc"
    "bash_profile"
    "zshrc"
    "zlogout"
    "inputrc"
    "gitconfig"
    "vimrc"
    "vim"
    "config"
    "ssh"
    "agents"
)

for file in "${SYMLINKS[@]}"; do
    target=$(readlink ~/.${file} || true)
    expected="$HOME/dotfiles/src/${file}"
    if [ "$target" != "$expected" ]; then
        echo "Symlink ~/.${file} target invalid! Expected: $expected, Got: $target"
        exit 1
    fi
    echo "[OK] Symlink ~/.${file} points to $target"
done

echo "=== 5. Testing Untracked configuration at repository root ==="
# Initialize update timestamp to bypass interactive update prompt in tests
current_day="$(($(date +%s) / 60 / 60 / 24))"
echo "$current_day" > ~/.dotfiles-update

mkdir -p ~/dotfiles/untracked
echo "export TEST_UNTRACKED_VAR='untracked_works'" > ~/dotfiles/untracked/bashconfig

# Run bash subshell to verify untracked sourcing
BASH_UNTRACKED=$(PS1=1 bash -i -c "echo __START__; echo \$TEST_UNTRACKED_VAR" 2>/dev/null | grep -A 1 "__START__" | tail -n 1)
if [ "$BASH_UNTRACKED" != "untracked_works" ]; then
    echo "Untracked bashconfig was not properly loaded in bash! Got: '$BASH_UNTRACKED'"
    exit 1
fi

# Run zsh subshell to verify untracked sourcing
if command -v zsh &>/dev/null; then
    ZSH_UNTRACKED=$(PROMPT=1 zsh -i -c "echo __START__; echo \$TEST_UNTRACKED_VAR" 2>/dev/null | grep -A 1 "__START__" | tail -n 1)
    if [ "$ZSH_UNTRACKED" != "untracked_works" ]; then
        echo "Untracked bashconfig was not properly loaded in zsh! Got: '$ZSH_UNTRACKED'"
        exit 1
    fi
else
    echo "[INFO] zsh not installed in current host, skipping zsh subshell test."
fi
echo "[OK] Untracked files loaded and working."

echo "=== 6. Testing Bash configuration & environment ==="
BASH_TEST=$(PS1=1 bash -i -c "echo __START__; alias ll" 2>/dev/null | grep -A 1 "__START__" | tail -n 1)
if [[ "$BASH_TEST" != *"ls -lh"* ]]; then
    echo "Bash alias 'll' not found or incorrect! Got: '$BASH_TEST'"
    exit 1
fi
echo "[OK] Bash execution & aliases working."

echo "=== 7. Testing Zsh configuration & plugins ==="
if command -v zsh &>/dev/null; then
    ZSH_TEST=$(PROMPT=1 zsh -i -c "echo \$ZSH" 2>/dev/null | tail -n 1)
    if [ "$ZSH_TEST" != "$HOME/dotfiles/src/zsh/oh-my-zsh" ]; then
        echo "Zsh \$ZSH export incorrect! Got: '$ZSH_TEST'"
        exit 1
    fi
    echo "[OK] Zsh execution and Oh My Zsh integration working."
else
    echo "[INFO] zsh not installed in current host, skipping Zsh configuration check."
fi

echo "=== 8. Testing .config folder contents (Coverage check > 80%) ==="
TOTAL_CONFIG_FILES=$(find ~/dotfiles/src/config -type f | wc -l)
LINKED_CONFIG_FILES=$(find ~/.config/ -type f | wc -l)

echo "Found $TOTAL_CONFIG_FILES total config files in src/config, $LINKED_CONFIG_FILES accessible via ~/.config"
if [ "$TOTAL_CONFIG_FILES" -eq 0 ] || [ "$LINKED_CONFIG_FILES" -lt "$TOTAL_CONFIG_FILES" ]; then
    echo "Config coverage check failed! Total: $TOTAL_CONFIG_FILES, Linked: $LINKED_CONFIG_FILES"
    exit 1
fi
echo "[OK] Config files tested (100% coverage)."

echo "=== ALL DOTFILES TESTS PASSED SUCCESSFULLY! ==="
