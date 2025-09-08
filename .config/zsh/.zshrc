unsetopt autocd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

setopt share_history
setopt inc_append_history

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

bindkey -e

zstyle :compinstall filename '/home/gianmarco/.zshrc'
autoload -Uz compinit; compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide
eval "$(zoxide init --cmd cd zsh)"

PS1='[%n@%m]%~%# '

. "$HOME/.local/bin/env"
