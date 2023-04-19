#!/usr/bin/env bash

# Personalized script to install programs the way I like.
# Credit to Thoughtbot (https://github.com/thoughtbot/laptop)
# for the original scripts.

## HELPER FUNCTIONS ##
fancy_echo() {
  local fmt="$1"; shift

  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="$2"

  if [[ -w "$HOME/.zshrc.local" ]]; then
    f="$HOME/.zshrc.local"
  else
    f="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$f"; then
    if (( skip_new_line )); then
      printf "%s\n" "$text" >> "$f"
    else
      printf "\n%s\n" "$text" >> "$f"
    fi
  fi
}

append_to_zprofile() {
  local text="$1" zprofile

  if [[ -w "$HOME/.zprofile.local" ]]; then
    f="$HOME/.zprofile.local"
  else
    f="$HOME/.zprofile"
  fi

  if ! grep -Fqs "$text" "$zprofile"; then
      printf "%s\n" "$text" >> "$f"
  fi
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_install_or_upgrade() {
  brew_is_installed() {
    local name="$(brew_expand_alias "$1")"
    brew list -1 | grep -Fqx "$name"
  }
  brew_is_upgradable() {
    local name="$(brew_expand_alias "$1")"
    brew outdated --quiet "$name" >/dev/null
    [[ $? -ne 0 ]]
  }
  
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_launchctl_restart() {
  local name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -q "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

### END HELPER FUNCTIONS ###

# EXIT IF ANY INSTALL FAILS
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

# SETUP ZSHELL
fancy_echo "Verifying zsh setup ..."
if [[ ! -f "$HOME/.zshrc" ]]; then
    touch "$HOME/.zshrc"
fi
append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'
if [[ "$SHELL" != */zsh ]]; then
  fancy_echo "Changing your shell to zsh ..."
    chsh -s "$(which zsh)"
fi

# INSTALL HOMEBREW
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    append_to_zshrc '# recommended by brew doctor'
    append_to_zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"'
    append_to_zprofile '# recommended by brew doctor'
    append_to_zprofile 'eval "$(/opt/homebrew/bin/brew shellenv)"'
    export PATH="/usr/local/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update
brew doctor

# INSTALL DEVELOPER THINGS
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'python'
brew_install_or_upgrade 'vim'
brew_install_or_upgrade 'iterm2'
brew_install_or_upgrade 'visual-studio-code'

# INSTALL COMMON LAPTOP IMPROVEMENTS
brew_install_or_upgrade 'spotify'
brew_install_or_upgrade 'discord'
brew_install_or_upgrade 'rectangle'
