#!/bin/zsh

HISTSIZE=16384
SAVEHIST=16384
HISTFILE=~/.zsh-history

setopt hist_verify
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups
