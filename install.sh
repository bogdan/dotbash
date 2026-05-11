
if [ -d /Users ] ; then
  USERHOME=/Users/bogdan
else
  USERHOME=/home/bogdan
fi
USERHOME=$HOME

DOTBASH=$USERHOME/.dotbash

[ -d $DOTBASH ] || ln -s `pwd` $DOTBASH

for FILE_NAME in .bashrc .irbrc .gemrc \
  .gitconfig .gitignore bin .zshrc .zsh .rubyrc \
  .rdebugrc .psqlrc .pryrc .tigrc .tmux.conf \
  .ctags .shellrc .shell_aliases
do
    FILE_PATH=$DOTBASH/$FILE_NAME
    rm -f $USERHOME/$FILE_NAME
    ln -s $FILE_PATH $USERHOME
done


if ! command -v rvm &> /dev/null; then
  \curl -sSL https://get.rvm.io | bash -s stable
fi

mkdir -p $USERHOME/tmp
touch $USERHOME/.irb_history
chmod a+rw $USERHOME/.irb_history
[ "$BASH_VERSION" ] && source $USERHOME/.bashrc
[ "$ZSH_VERSION" ] && source $USERHOME/.zshrc

