#!/bin/zsh

autoload -U colors && colors

source ~/.dotbash/.shellrc


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


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [[ -d /usr/local/share/zsh-completions ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

autoload -U compinit && compinit
autoload -U compdef

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use 
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# FZF

setopt HIST_IGNORE_ALL_DUPS
FZF_DIR="`dirname $(realpath $(which fzf))`/.."
if [ -d $FZF_DIR ]; then
  [[ $- == *i* ]] && source "$FZF_DIR/shell/completion.zsh" 2> /dev/null
  source "$FZF_DIR/shell/key-bindings.zsh"
fi

# Created by `pipx` on 2024-10-07 13:07:02
export PATH="$PATH:/Users/bogdan/.local/bin"
