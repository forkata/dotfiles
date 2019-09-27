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
  ln -sf "$(pwd)/.ackrc" "$HOME/.ackrc"
  ln -sf "$(pwd)/.agignore" "$HOME/.agignore"
  ln -sf "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$(pwd)/.xbindkeysrc" "$HOME/.xbindkeysrc"
  ln -sf "$(pwd)/.Xresources" "$HOME/.Xresources"
  ln -sf "$(pwd)/.Xmodmap" "$HOME/.Xmodmap"
  ln -sf "$(pwd)/.urxvt" "$HOME/.urxvt"

  # vim
  ln -sf "$(pwd)/.vimrc" "$HOME/.vimrc"
  mkdir -p ~/.vim/tmp

  # install Vundle.vim and plugins
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
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
