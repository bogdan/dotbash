#!/bin/zsh

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U compdef

[ -f ~/.bashrc ] && source ~/.bashrc


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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [[ -f /usr/local/share/zsh-completion ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

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

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
