if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX=true

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias gits="git status"
alias gitka="gitk --all"
alias lg="/Users/nb-dcubelic/Developer/lazygit/lazygit"
alias xcdel="rm -rf /Users/nb-dcubelic/Library/Developer/Xcode/DerivedData/*"
alias wdel="rm -rf /Users/nb-dcubelic/Work"

alias cat='bat'
alias json='fx'
alias ls='exa'
alias hex='hexyl'
alias adblog='pidcat -w30 -ld'
alias vim='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
