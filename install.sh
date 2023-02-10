#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

DOTFILES_PATH=$SCRIPTPATH

cd $HOME

# setup zshell
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm $HOME/.zshrc $HOME/.p10k.zsh
ln -s $DOTFILES_PATH/p10k.zsh $HOME/.p10k.zsh
ln -s $DOTFILES_PATH/zshrc $HOME/.zshrc

# setup tmux
ln -s $DOTFILES_PATH/tmux.conf $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# setup nvim
ln -s $DOTFILES_PATH/nvim $HOME/.config/nvim
