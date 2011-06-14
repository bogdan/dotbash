#!/bin/sh

[ $ZSH_VERSION ] || (type zsh &> /dev/null && zsh && exit 0)

tty -s && echo "=> ~/.bashrc"

# If not running interactively, don't do anything
export HISTCONTROL=ignoredups

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Time zone
TZ='Europe/Kiev'; export TZ

# History size
export HISTSIZE="10000"

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

# ksh specific
if [ $SHELL = "/bin/ksh" ] ; then
	set -o vi -o viraw
fi
export PS1



if [ -d "/var/lib/gems/1.8/bin" ] ; then
    PATH="$PATH:/var/lib/gems/1.8/bin"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

# Java rc
export JDK_HOME='/usr/lib/jvm/default-java'
export JAVA_HOME="$JDK_HOME" 
export CLASSPATH=":$HOME/test/java:.:"



# hosts




#
# Editor
#
 
if [ $DISPLAY ] ; then
	if [ "`which gvim`" ] ; then
	       	EDITOR="gvim"
	elif [ "`which vi`" ] && [ $TERM ] ; then
		EDITOR="$TERM -x vi"
	fi
else
	if [ "`which vi`" ] ; then
		EDITOR="vi"
	fi
fi
export EDITOR

if [ "`which less`" ] ; then 
	PAGER="less -i"
elif [ "`which more`" ] ; then 
	PAGER="more -i"
fi
export PAGER

export BROWSER="chromium-browser"



#
# Places
# 

if [ -d /home/bogdan/makabu ] ; then
    export PEROOZAL='/home/bogdan/makabu/railsware/peroozal/repository'
    export STARTWIRE='/home/bogdan/makabu/railsware/startwire/repository'
    export MANAGE='/home/bogdan/makabu/railsware/product_manager'
    export INBIZ='/home/bogdan/makabu/inbiz/repository'
fi

if [ -d /var/data/www/apps/ ] ; then 
    export STARTWIRE="/var/data/www/apps/startwire/current"
fi

export RUBY_GEMS='/var/lib/gems/1.8/gems/'
   



[ -f ~/.bash_aliases ] && source ~/.bash_aliases




export RET="RAILS_ENV=test"
export REP="RAILS_ENV=production"
mkcd()
{
	mkdir $1
	cd $1
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
