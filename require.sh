#!/bin/sh
<<<<<<< HEAD

apt-get install skype #exclusive



#Server goodies
apt-get install vim-gnome ttf-inconsolata tig htop nmap zsh curl ctags 


apt-get install zip unzip rar unrar

apt-get install skype #exclusive

apt-get install xserver-xorg-input-synaptics-dev kupfer workrave chromium-browser \
    vlc shutter \
    flashplugin-installer transmission-gtk ttf-mscorefonts-installer



apt-get install postgresql redis-server libpq-dev openjdk-6-jdk etckeeper rhino

vi /etc/postgresql/8.4/main/pg_hba.conf 
service postgresql restart

vi /etc/etckeeper.conf
etckeeper init





apt-get install ruby rubygems ruby-dev

apt-get install libxslt1-dev libxml2-dev  curl libreadline-dev libsqlite3-dev


gem install --no-ri --no-rdoc \
    bundler shelltoad rails rspec-rails  pivotal_shell resque resque_scheduler \
    pg system_timer sunspot_rails ruby-debug bond wirble ruby-debug-ide rake \
    jeweler hirb


vi /etc/hosts