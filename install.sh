
if [ -d /Users ] ; then
  USERHOME=/Users/bogdan
else
  USERHOME=/home/bogdan
fi

DOTBASH=$USERHOME/.dotbash

[ -d $DOTBASH ] || ln -s `pwd` $DOTBASH

for FILE_NAME in .bashrc .bash_aliases .irbrc .gemrc \
  .gitconfig .gitignore .vim bin .zshrc .zsh .rubyrc \
  .rdebugrc .psqlrc .pryrc .tigrc .screenrc .tmux.conf
do
    FILE_PATH=$DOTBASH/$FILE_NAME
    rm -f $USERHOME/$FILE_NAME
    ln -s $FILE_PATH $USERHOME
done

