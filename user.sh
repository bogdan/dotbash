USERHOME=/home/bogdan

sudo apt-get install zsh curl git-core
sudo useradd -d $USERHOME --groups users,sudo -m -s `type -p zsh` bogdan 
sudo mkdir -p $USERHOME
sudo mkdir -p $USERHOME/.ssh
sudo sh -c "curl https://raw.github.com/bogdan/dotbash/master/authorized_keys >> $USERHOME/.ssh/authorized_keys"
sudo chown -R bogdan:bogdan $USERHOME

sudo -u bogdan sh -c "curl -L https://raw.github.com/bogdan/dotbash/master/clone.sh | bash -s stable"
sudo passwd bogdan
sudo visudo
