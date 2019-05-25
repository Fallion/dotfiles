# Path to ZSH
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"


# Flutter setup 
export PATH="$PATH:~/development/flutter/bin"

# Go Setup
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh