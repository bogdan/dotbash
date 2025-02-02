source ~/.dotbash/.shellrc

if [ "$BASH_VERSION" ]   ; then
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
. "$HOME/.cargo/env"
