#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Check for Homebrew and install it if missing
	if test ! $(which brew)
	then
		echo "Installing Homebrew..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

    apps=(
		git
	)
	brew install "${apps[@]}"

    git init

fi

mkdir dotfiles
cd dotfiles

git remote add origin git@github.com:Fallion/dotfiles.git

# Symlink dotfiles
git pull origin master;