unsetopt autocd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

setopt share_history
setopt inc_append_history

export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export MANWIDTH=80

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export PATH="$HOME/.local/bin:$PATH"

bindkey -e

autoload -U colors && colors
PS1="%B%{$fg[green]%}[%n@%m:%~]%#%{$reset_color%}%b "

zstyle :compinstall filename '/home/gianmarco/.config/zsh/.zshrc'
autoload -Uz compinit; compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide
eval "$(zoxide init zsh)"

# Set up brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
