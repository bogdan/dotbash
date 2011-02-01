#!/bin/bash

alias eject="eject -T" 
alias p="ping"
alias pg="ping google.com"
alias m='mplayer -osdlevel 3 -idx'
alias s='screen'
alias vol='amixer sset PCM'
alias cdrecord="cdrecord dev=/dev/cdrom gracetime=5 -multi"
alias mkisofs="mkisofs -J -R"
alias mc="mc --colors normal=cyan,default:marked=green,default:directory=brown,default:errors=red,default:executable=red,default:link=green,default:device=magenta,default: menu=white,default:menuhot=white,default:menusel=white,default:menuhotsel=white,default:helpnormal=white,default:helplink=white,default:helpslink=white,default:helpitalic=white,default:reverse=brown,default:gauge=brown,default:input=brown,default:selected=white,default:markselect=brown,gray"
alias au='audacious'
alias locate='locate -i'
alias j='jobs'
alias g='grep -r --color=auto -i'
alias vg='grep --color=auto -iv'
alias feh='feh -dzg 1024x768'
alias mloop="sudo mount -o loop"
alias psg="ps aux | grep --color=auto -i"
alias grey="convert -fx \(r+g+b\)/3"
alias x="chmod a+x"
alias rw="chmod u+rw"
alias ymd="date +%g.%m.%d"
alias dtail="dmesg | tail -n 20"

alias t="tail -n10"
alias t2="tail -n100"
alias t3="tail -n1000"
alias tf="tail -f"

alias l="less -i -R"
alias less='less -i -R'
   
# APT
alias ag="sudo apt-get -V"
alias ai="sudo apt-get -V install"
alias ac="apt-cache"
alias ash="apt-cache show" 
alias as="apt-cache search"

alias gh="history | grep --color=auto -i"

alias h='htop'

# Nice output on linux
if [ "`uname -s`" = "Linux" ] ; then
	alias du="du -h"
	alias df="df -h"
fi


# ICONV
alias koi2win="iconv -cf koi8-r -t cp1251"
alias win2koi="iconv -cf cp1251 -t koi8-r"
alias utf2koi="iconv -cf utf8 -t koi8-r"
alias koi2utf="iconv -cf koi8-r -t utf8"

# LS
ls --color > /dev/null 2> /dev/null && COLOR="--color"
alias ls='ls -F $COLOR'
alias ll='ls $COLOR -hFl'
alias la='ls $COLOR -Fa'
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';
export LS_COLORS

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

alias re="source ~/.bashrc"

#
# Git
#

alias gst="git status"
alias glg="git log -p"
alias gps="git push"
alias gpl="git pull"
alias gpp="git pull && git push"
alias gad="git add"
alias gci="git commit"
alias gco="git checkout"
alias gdf="git diff --color"
alias gdfs="git diff --staged"
alias ppd="gpl && gps && cap staging deploy"


#function bashgit {
    #cd ~/.dotbash
    #git $@
    #cd - > /dev/null
#}
#alias bashpl="cd ~/.dotbash/; git pull; cd -"
#alias bashps="cd ~/.dotbash/; git push; cd -"


#
# Ruby
#

alias gem="sudo gem"
alias r="rake --trace -r rubygems"
alias rt="rake -T -r rubygems"
alias rake="rake --trace -r rubygems"
alias gi="sudo gem install"
alias gu="sudo gem uninstall"
alias gl="gem list"
alias gs="gem search --remote"

alias jgem="sudo jruby -S gem"
alias jr="jruby -S rake"

alias csd="cap staging deploy"
alias cpd="cap production deploy"


#
# Just sudo
#

alias service="sudo service"
alias deployer="sudo -u deployer"
alias svi="sudo vi"
