#!/usr/bin/env bash

cd "$( dirname "$0" )"
git pull origin master

function bootstrap() {
	# zsh
	ln -sf "$(pwd)/.zprezto" "$HOME/.zprezto"
	ln -sf "$(pwd)/.zlogin" "$HOME/.zlogin"
	ln -sf "$(pwd)/.zlogout" "$HOME/.zlogout"
	ln -sf "$(pwd)/.zprofile" "$HOME/.zprofile"
	ln -sf "$(pwd)/.zpreztorc" "$HOME/.zpreztorc"
	ln -sf "$(pwd)/.zshenv" "$HOME/.zshenv"
	ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"

	# git
	ln -sf "$(pwd)/.gitconfig" "$HOME/.gitconfig"
	ln -sf "$(pwd)/.gitignore_global" "$HOME/.gitignore_global"

	# dev
	ln -sf "$(pwd)/.bundle" "$HOME/.bundle"
	ln -sf "$(pwd)/.ackrc" "$HOME/.ackrc"
	ln -sf "$(pwd)/.agignore" "$HOME/.agignore"

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
