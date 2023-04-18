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
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if (( skip_new_line )); then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
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
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update

brew_install_or_upgrade 'git'
brew_install_or_upgrade 'postgres'
fancy_echo "Restarting Postgres ..."
  brew_launchctl_restart postgresql
