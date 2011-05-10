#!/bin/zsh

#[ -f ~/.bashrc ] && source ~/.bashrc
autoload -U colors && colors


alias re="source ~/.zshrc"


ZSH_DIR="$HOME/.zsh"

if [[ -d $ZSH_DIR && -r $ZSH_DIR && \
    -x $ZSH_DIR ]]; then
    for i in $(LC_ALL=C command ls "$ZSH_DIR"); do
        i=$ZSH_DIR/$i
        [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|*.rpm@(orig|new|save)) \
            && ( -f $i || -h $i ) && -r $i ]] && . "$i"
    done
fi
unset i


PATH="$PATH:`git --exec-path`"
