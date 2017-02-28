#!/usr/bin/env bash

cd "$( dirname "$0" )"
git pull origin master

function bootstrap() {
  # zsh
  ln -sf "$(pwd)/.zshenv" "$HOME/.zshenv"
  ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"
  ln -sf "$(pwd)/.zsh" "$HOME/.zsh"

  # git
  ln -sf "$(pwd)/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$(pwd)/.gitignore_global" "$HOME/.gitignore_global"
  ln -sf "$(pwd)/.git-template" "$HOME/.git-template"

  # dev
  ln -sf "$(pwd)/.bundle" "$HOME/.bundle"
  ln -sf "$(pwd)/.ackrc" "$HOME/.ackrc"
  ln -sf "$(pwd)/.agignore" "$HOME/.agignore"
  ln -sf "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$(pwd)/.xbindkeysrc" "$HOME/.xbindkeysrc"

  # vim
  ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  bootstrap
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    bootstrap
  fi
fi
unset bootstrap
