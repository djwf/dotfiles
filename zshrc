#!/bin/bash
# vim: foldmethod=marker foldenable

# COLOR {{{1

autoload -U colors && colors


# COMPLETION {{{1
autoload -U compinit && compinit
setopt completeinword
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt extendedglob
unsetopt caseglob
setopt auto_cd


# HISTORY {{{1
HISTSIZE=1000
HISTFILE=~/.history
SAVEHIST=1000
setopt SHARE_HISTORY


# ALIASES {{{1
# Shortcuts
alias npmls="npm ls --depth=0"
alias V="vim +V"
alias g="git"
alias gl="git log"
alias gs="git status"
alias please="sudo !!"
alias pls=please

# Better defaults
alias ghc="ghc -Wall -Werror"
alias vim="nvim" # Use `\vim` for true vim
alias less="less -FSRX"

# Rarely used
alias install-spacemacs="git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d"


# FUNCTIONS {{{1
function rc {
  case "$1" in
    vim|vi|v        ) $EDITOR ~/.vimrc                ;;
    neovim|nvim|n   ) $EDITOR ~/.nvimrc               ;;
    zsh|z           ) $EDITOR ~/.zshrc                ;;
    i3              ) $EDITOR ~/.i3/config            ;;
    xinit|xorg|x11|x) $EDITOR ~/.xinitrc              ;;
    bspwm|bs|b      ) $EDITOR ~/.config/bspwm/bspwmrc ;;
    sxhkd|sx|s      ) $EDITOR ~/.config/sxhkd/sxhkdrc ;;
    compton|comp|co ) $EDITOR ~/.compton.config       ;;
    *               ) echo "Not defined"              ;;
  esac
}

function mkcd() {
  if [[ $1 = "" ]]; then
    echo "Usage: mkcd <dir>";
  else
    mkdir -p $1
    cd $1
  fi
}

function foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job
bindkey -M viins '^z' foreground-current-job
bindkey -M vicmd '^z' foreground-current-job


# ENVIRONMENT VARIABLES {{{1
export PATH=$HOME/.local/bin::$HOME/.cabal/bin:$PATH
export EDITOR="nvim"
setopt PROMPT_SUBST
export NL=$'\n' # newline
# export PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}% $ "
# export PROMPT="%{$fg_no_bold[yellow]%}%1~ %{$reset_color%}% λ "
export PROMPT="${NL}%F{yellow}%4~ %(!.%F{red}.%F{white}) %fλ "
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1


# OS SPECIFIC {{{1

# Linux
if [[ "$(uname -s )" == "Linux" ]]; then
  export PATH=$HOME/.npm/bin:$PATH
  alias ls="/bin/ls -AFph --group-directories-first --color=always"
  alias xload="xrdb -load ~/.Xresources"
fi

# Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias ls="/bin/ls -AGFh"
  alias ds-clean="sudo asepsisctl -v migratein"
  alias cask="brew cask"
  alias nvim="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"
  alias show-files="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
  alias hide-files="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
fi


