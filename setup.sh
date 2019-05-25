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
	brew tap homebrew/versions
	brew upgrade --all

	apps=(
		git
        go
		node
		python
		python3
		wget
	)
	brew install "${apps[@]}"
	sudo easy_install pip

	# Install Caskroom
	brew tap caskroom/cask
	brew tap caskroom/versions

	apps=(
		cyberduck
		docker
		discord
		brave-browser
		insomnia
		slack
		spotify
		steam
		visual-studio-code
	)
	brew cask install "${apps[@]}"

	# Remove outdated versions from the cellar
	brew cleanup

	# Set screencapture location
	defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
	killall SystemUIServer

	# Set Dock items
	OLDIFS=$IFS
	IFS=''

	apps=(
		'Brave Browser'
		'Visual Studio Code'
		Insomnia
		Spotify
		Slack
		Cyberduck
		'System Preferences'
	)

	dockutil --no-restart --remove all $HOME
	for app in "${apps[@]}"
	do
		echo "Keeping $app in Dock"
		dockutil --no-restart --add /Applications/$app.app $HOME
	done
	killall Dock

	# restore $IFS
	IFS=$OLDIFS

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Make sure we’re using the latest repositories
	apt update

	apps=(
        go
		git
		nodejs
		npm
		python
		python3
		screen
		wget
	)
	apt install "${apps[@]}"
    apt install python-pip python-dev build-essential
fi

cd "$(dirname "${BASH_SOURCE}")";

git init
git remote add origin git@github.com:Fallion/dotfiles.git

# Symlink dotfiles
git pull origin master;

for file in $(ls -A); do
if [ "$file" != ".git" ] && \
   [ "$file" != "setup.sh" ] && \
   [ "$file" != "remote-setup.sh" ] && \
   [ "$file" != "README.md" ] && \
   [ "$file" != "images" ]; then
    ln -sf $PWD/$file $HOME/
fi
done