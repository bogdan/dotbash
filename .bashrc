#!/bin/sh


[[ $- == *i* ]] || return

export _Z_NO_RESOLVE_SYMLINKS=1
source ~/.dotbash/bin/z.sh
# If not running interactively, don't do anything
export HISTCONTROL=ignoredups

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Time zone
TZ='Europe/Kiev'; export TZ


# Funny message
[ -x /usr/games/fortune ] && fortune


# default PS1
PS1="`whoami`@`hostname` \${PWD} > "

# bash specific
if [ "$BASH_VERSION" ] ; then
	if [ -f /etc/bash_completion ]; then
    		. /etc/bash_completion
	fi
	green="\[\033[32m\]"
	blue="\[\033[34m\]"
	magenta="\[\033[35m\]"
	cyan="\[\033[36m\]"
	bold="\[\033[01m\]"
	normal="\[\033[00;00;00m\]"
	red="\[\033[31;01m\]"

	# ps1 4 user 
  branch="$cyan\`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\\\\\*\ \(.+\)$/\\\\\\\\\1\ /\`"
	PS1="$green\u@`hostname`$blue \w $branch$normal$ "
	# ps1 4 root
	[ $UID -eq 0 ] && \
		PS1="$red\h $blue\w # $normal"
	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize
fi

export PS1



if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -f "$HOME/.ssh/id_rsa" ] && [ ! "`ssh-add -l | grep id_rsa`" ]; then
  ssh-add $HOME/.ssh/id_rsa > /dev/null
fi

#
# Editor
#
 
if [ $DISPLAY ] || [ `uname` = Darwin ] ; then
  if which gvim > /dev/null ; then
    EDITOR="gvim"
  elif which mvim > /dev/null ; then
    EDITOR="mvim"
  fi
elif which vi > /dev/null ; then
  EDITOR="vi"
fi
export EDITOR

if [ "`which less`" ] ; then 
	PAGER="less -i"
elif [ "`which more`" ] ; then 
	PAGER="more -i"
fi
export PAGER

if which chromium-browser > /dev/null ; then 
  BROWSER="chromium-browser"
elif [ -f /Applications/Google\ Chrome.app ] ; then
  BROWSER="open /Applications/Google\ Chrome.app"
fi
export BROWSER



#
# Places
# 

if [ -f "$HOME/.rubyrc/bogdan.rb" ]; then
  RUBYLIB="$HOME/.rubyrc"
  RUBYOPTS="-r bogdan"
  RUBYOPT="rbogdan"
  export RUBYLIB RUBYOPT
fi 



[ -f ~/.bash_aliases ] && source ~/.bash_aliases


export RET="RAILS_ENV=test"
export REP="RAILS_ENV=production"
mkcd()
{
	mkdir $1
	cd $1
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
