#!/bin/zsh

git_prompt_info() {
    if [ -d .svn ]; then
        ref=.svn
    else
        ref=${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/} || \
        ref=${$(git rev-parse HEAD 2>/dev/null)[1][1,7]} || \
        return
    fi
    case "$ref" in ????????????????????*) ref="${ref[1,17]}..." ;; esac
    echo ${ref}
}



export PS1="%{%F{green}%}%n@%m %{%F{blue}%}%~ %{%F{cyan}%}\$(git_prompt_info) %{%f%}$%\ "


setopt promptsubst
