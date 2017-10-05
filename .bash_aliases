#!/bin/bash

[ $ZSH_VERSION ] || alias compdef="true"

alias eject="eject -T" 
alias p="ping"
alias pg="ping google.com"
alias s='screen'
alias cdrecord="cdrecord dev=/dev/cdrom gracetime=5 -multi"
alias mkisofs="mkisofs -J -R"
alias mc="mc --colors normal=cyan,default:marked=green,default:directory=brown,default:errors=red,default:executable=red,default:link=green,default:device=magenta,default: menu=white,default:menuhot=white,default:menusel=white,default:menuhotsel=white,default:helpnormal=white,default:helplink=white,default:helpslink=white,default:helpitalic=white,default:reverse=brown,default:gauge=brown,default:input=brown,default:selected=white,default:markselect=brown,gray"
alias locate='locate -i'
alias j='jobs'
alias g='grep  --color=auto -i'
alias gr='grep -r --color=auto -i'
type ack > /dev/null 2> /dev/null || alias ack="ack-grep"
type ack > /dev/null 2> /dev/null && alias ack-grep="ack"
alias vg='grep --color=auto -iv'
alias gw='grep --color=auto -w'
alias ge='grep --color=auto -E'
alias gf='find . | grep --color=auto -i'
alias mloop="sudo mount -o loop"
alias psg="ps aux | grep --color=auto -i"
alias grey="convert -fx \(r+g+b\)/3"
alias x="chmod a+x"
#compdef _chmod x=chmod a+x
alias rw="chmod u+rw"
#compdef _chmod rw=chmod a+x
alias ymd="date +%g.%m.%d"
alias dtail="dmesg | tail -n 20"
alias hd="head"

alias t="tail -n1000"
alias t2="tail -n100"
alias t3="tail -n1000"
alias t4="tail -n10000"
alias t5="tail -n100000"
alias tf="tail -n100 -f"

alias l="less -i -R"
alias less='less -i -R'
   
# APT
alias ag="sudo apt-get -V"
alias ai="sudo apt-get -V install"
alias ac="apt-cache"
alias ash="apt-cache show" 
#compdef _apt-cache ash=apt-cache show
alias as="apt-cache search"
#compdef _apt-cache as=apt-cache search

alias gh="history | grep --color=auto -i"


myhtop() {
  if [ `uname` = Darwin ] ; then
    sudo htop
  else
    htop
  fi
}
alias h='myhtop'

# Nice output on linux
alias du="du -h"
alias dus="du -h -s"
alias dust="du -h -s *"
alias df="df -h"


# ICONV
alias koi2win="iconv -cf koi8-r -t cp1251"
alias win2koi="iconv -cf cp1251 -t koi8-r"
alias utf2koi="iconv -cf utf8 -t koi8-r"
alias koi2utf="iconv -cf koi8-r -t utf8"

# LS
ls -G > /dev/null 2> /dev/null && COLOR="-G"
ls --color > /dev/null 2> /dev/null && COLOR="--color"
alias ls="ls -F $COLOR"
alias l1="ls -1"
alias ll="ls $COLOR -hFl"
alias la="ls $COLOR -Fa"
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';
export LS_COLORS

alias wl="wc -l"

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

alias re="source ~/.bashrc"


#
# Git
#

alias gad="git add"
#compdef _git gad=git-add

alias gcl="git clone"
alias grp="git grep -n --color"

alias gst='git status'
#compdef _git gst=git-status
alias gpl='git pull'
#compdef _git gl=git-pull
alias gup='git fetch && git rebase'
#compdef _git gup=git-fetch
alias gps='git push'
#compdef _git gp=git-push
alias gdf="git diff --color"
alias gdc="git diff --cached --color"
#compdef _git gdf=git-diff
alias gdc="git diff --color --cached"
alias gds="git diff --color --stat"
alias gci='git commit -v'
alias gsi='git storyid'
#compdef _git gc=git-commit
alias gca='git commit --amend'
#compdef _git gca=git-commit
alias gco='git checkout'
alias gcm='git checkout master'
alias gcb='git checkout bogdan'
#compdef _git gco=git-checkout
alias gbr='git branch'
#compdef _git gb=git-branch
alias gba='git branch -a'
alias gbd='git branch -d'
#compdef _git gba=git-branch
alias gcount='git shortlog -sn'
#compdef gcount=git
alias gcp='git cherry-pick'
#compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=5'
#compdef _git glg=git-log
alias gsi="git storyid"
alias gsh="git stash -u"
alias gsp="git stash pop"
alias grs="git reset"
alias grh="git reset 'HEAD^'"
alias gdo="git commit -m 'do'"
alias ggo="git add . && git commit -m 'do' && git push"

alias glp="git log -p"
alias gbl="git blame"
alias gg="git grep -w --color"
alias gm="git merge"
alias gmb="git merge bogdan"
alias gmm="git merge master"
alias gma="git merge --abort"
alias gfu="git fetch upstream"
alias gmum="git merge upstream/master"
alias gmom="git merge origin/master"
# Only current branch
alias gpf="git push -f origin \$(git rev-parse --abbrev-ref HEAD)"
alias grv="git revert"
alias gcn="git clean -fd"
gap() {
  git add . && git ci $@ && git push
}

gac() {
  heading=`git diff --stat --cached | head -1`
  message=`git diff --cached --no-color`
  git commit -m "$heading

$message"
}
alias gpp="git pull && git push"
alias ppd="gpl && (gps; cap staging deploy)"

gtr() {
  branch=`git branch | grep "*" | sed "s/* //g"`
  git branch --set-upstream $branch origin/$branch
}

 



bashgit() {
    cd ~/.dotbash
    git $@
    cd - > /dev/null
    return true
}
#compdef _git bashgit=git
alias bashpl="cd ~/.dotbash/; git pull; cd - > /dev/null"
alias bashps="cd ~/.dotbash/; git push; cd - > /dev/null"


#
# Ruby
#

myrake() 
{
    RAKE="rake --trace -r rubygems"
    if [ -f Gemfile ] ; then
        bundle exec rake --trace -r rubygems $@
    else
        \rake --trace -r rubygems $@
    fi
}
alias r="myrake"

alias rt="myrake -T"
alias rtg="myrake -T | grep"
alias rrg="rake routes | grep"

alias rake="myrake"
alias rrg="myrake routes | g"
alias gi="gem install"
alias gu="gem uninstall"
alias gl="gem list"
alias gs="gem search --remote"
alias go="gem open"

alias jgem="sudo jruby -S gem"
alias jr="jruby -S rake"
alias unit="ruby -I'lib:test'"
alias pt='parallel_test'
alias ptt='parallel_test test'
alias pts="parallel_rspec spec"

alias csd="cap staging deploy"
alias cdd="cap dev deploy"
alias cpd="cap production deploy"

alias pci="rvm system do pivotal commit"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"

alias rsp="bundle exec rspec --format Fuubar --drb"

alias zr="zeus rake"
alias zt="zeus test"
alias zc="zeus console"
alias zs="zeus start"

alias k='kill'
alias k9='kill -9'
kg() {
  kill $@ && ps aux | grep $@
}
k9g() {
  kill -9 $@ && ps aux | grep $@
}

#
# Just sudo
#

alias service="sudo service"
alias deployer="sudo -u deployer"
#compdef _sudo deployer=sudo
alias svi="sudo vi"

if [ -d ~/makabu/allan ] ; then
  alias curebit="cd ~/makabu/allan/curebit-marketing; git status"
  alias devauc="cd ~/makabu/allan/devauc; git status"
fi


#gvim()
#{
  #(unset GEM_PATH GEM_HOME; command gvim "$@")
#}
alias xfce4-terminal="xfce4-terminal --hide-menubar"
