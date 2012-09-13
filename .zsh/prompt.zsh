#!/bin/zsh

git_prompt_info() {
    if [ -d .svn ]; then
        ref=.svn
    else
        ref=${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/} || \
        ref=${$(git rev-parse HEAD 2>/dev/null)[1][1,7]} || \
        return
    fi
    case "$ref" in ????????????????????*) ref="${ref[1,17]}... " ;; esac
    echo "${ref} "
}


ruby_version() {
  type ruby > /dev/null && ruby -v | awk '{print $2 }'
}

export PS1="%{$fg[green]%}%n@%m %{$fg[blue]%}%~ %{$fg[cyan]%}\$(git_prompt_info)%{$fg[yellow]%}\$(ruby_version)%{$reset_color%} $%\ "


setopt promptsubst
