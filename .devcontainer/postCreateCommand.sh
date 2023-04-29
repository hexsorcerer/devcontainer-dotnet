#!/bin/sh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp .devcontainer/.zshrc ~/.zshrc
cp .devcontainer/.p10k.zsh ~/.p10k.zsh
git config --global user.email "$1"
git config --global user.name "$2"
