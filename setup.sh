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

	# Make sure we’re using the latest Homebrew
	brew update
	# Upgrade any already-installed formulae
	brew upgrade --all

	# Add tap for Dart
	brew tap dart-lang/dart

	echo "Installing Brew apps..."
	apps=(
		git
        go
		node
		python
		python3
		wget
		zsh
		make
		dart
	)
	brew install "${apps[@]}"
	sudo easy_install pip

	# Install Caskroom
	brew tap caskroom/cask
	brew tap caskroom/versions

	echo "Installing Brew Casks..."
	apps=(
		gitkraken
		cyberduck
		docker
		discord
		brave-browser
		insomnia
		slack
		spotify
		steam
		visual-studio-code
		1password
		graphql-playground
		now
		electron
		google-cloud-sdk
		kubernetes-cli
		minikube
		keybase
	)
	brew cask install "${apps[@]}"

	# Remove outdated versions from the cellar
	brew cleanup

	# Set screencapture location
	defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
	killall SystemUIServer

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Make sure we’re using the latest repositories
	sudo apt update
	sudo apt install snapd

	apps=(
		go
		node
        spotify
		code
		slack
		gitkraken
		docker
		brave
		insomnia
	)
	sudo snap install "${apps[@]}" --classic
fi

cd "$(dirname "${BASH_SOURCE}")";

git init
git remote add origin git@github.com:Fallion/dotfiles.git

# Symlink dotfiles
git pull origin master;

ln -sv $CWD/.zshrc ~/.zshrc
ln -sv $CWD/.gitconfig ~/.gitconfig

done