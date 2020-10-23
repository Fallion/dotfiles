#!/usr/bin/env bash

# Ask for the administrator password upfront
# sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update
# Upgrade any already-installed formulae
brew upgrade

# Add tap for Dart
brew tap dart-lang/dart

echo "Installing Brew apps..."
apps=(
	git
	go
	n
	node
	python
	python3
	wget
	zsh
	make
	dart
	kubernetes-cli
	protobuf
	starship
	fish
)
brew install "${apps[@]}"
sudo easy_install pip

# Install Caskroom
brew tap homebrew/cask
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

echo "Installing Brew Casks..."
apps=(
	gitkraken
	docker
	brave-browser
	insomnia
	slack
	spotify
	visual-studio-code
	1password
	electron
	google-cloud-sdk
	keybase
	bloomrpc
	notion
	font-fira-code
)
brew cask install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup

# Set screencapture location
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
killall SystemUIServer

cd "$(dirname "${BASH_SOURCE}")";

git init
git remote add origin git@github.com:fallion/dotfiles.git

# Symlink dotfiles
git pull origin master;

ln -sv $CWD/.zshrc ~/.zshrc
ln -sv $CWD/.gitconfig ~/.gitconfig

done