#!/usr/bin/env bash

pushd ~

printf "\n\nInstalling Hombrew\n\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

printf "\n\nInstalling chezmoi\n\n"
brew install chezmoi

printf "\n\nCloning dotfiles\n\n"
chezmoi init --apply danielgatis

printf "\n\nInstalling homebrew packages\n\n"
brew bundle --global --force --no-lock || true

printf "\n\nInstalling tmux plugins\n\n"
tmux start-server
tmux new-session -d
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

popd
