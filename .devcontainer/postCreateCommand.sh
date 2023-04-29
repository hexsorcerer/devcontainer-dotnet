#!/bin/sh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/' ~/.zshrc
git config --global user.email "$1"
git config --global user.name "$2"
