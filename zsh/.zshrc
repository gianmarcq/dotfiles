unsetopt autocd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

bindkey -e

zstyle :compinstall filename '/home/gianmarco/.zshrc'
autoload -Uz compinit; compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide
eval "$(zoxide init --cmd cd zsh)"

. "$HOME/.cargo/env"
