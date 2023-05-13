#!/usr/bin/env bash

pushd ~

if [ -d "/opt/homebrew/bin/brew" ]; then
  echo "Updating Homebrew"
  brew update
else
  echo "Installing Hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "Installing chezmoi"
  brew install chezmoi
fi

echo "Cloning dotfiles"
chezmoi init --apply danielgatis

echo "Installing packages"
brew bundle --global --force --no-lock || true

if [ "$TERM_PROGRAM" = tmux ]; then
  sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh
else
  tmux start-server
  tmux new-session -d
  sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh
  tmux kill-server
fi

popd
