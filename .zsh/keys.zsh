
WORDCHARS=""

bindkey -e

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

bindkey ';3D' emacs-backward-word
bindkey ';3C' emacs-forward-word
bindkey ';5D' backward-char
bindkey ';5C' forward-char

