#!/bin/sh


#Server goodies
apt-get install vim ttf-inconsolata tig htop nmap zsh curl ctags ack-grep etckeeper

vi /etc/etckeeper.conf
etckeeper init

apt-get install zip unzip rar unrar

apt-get install skype #exclusive

apt-get install xserver-xorg-input-synaptics-dev kupfer workrave chromium-browser \
    vlc shutter vim-gnome wine \
    openjdk-6-jdk \
    flashplugin-installer transmission-gtk ttf-mscorefonts-installer



apt-get install redis-server 

apt-get install mysql-server libmysql-dev

apt-get install postgresql libpq-dev
vi /etc/postgresql/8.4/main/pg_hba.conf 
service postgresql restart



apt-get install ruby rubygems ruby-dev

apt-get install libxslt1-dev libxml2-dev  curl libreadline-dev libsqlite3-dev \
    

apt-get install libmagick9-dev  #rmagic

gem install --no-ri --no-rdoc \
    bundler shelltoad rails rspec-rails  pivotal_shell resque resque-scheduler \
    pg system_timer ruby-debug bond wirble ruby-debug-ide rake \
    jeweler hirb showoff \
    ripl-rails ripl-color_error ripl-color_result \
    gem-ctags


vi /etc/hosts
