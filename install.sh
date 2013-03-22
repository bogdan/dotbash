
USERHOME=/Users/bogdan
DOTBASH=$USERHOME/.dotbash

[ -d $DOTBASH ] || ln -s `pwd` $DOTBASH

for FILE_NAME in .bashrc .bash_aliases .irbrc .gemrc \
  .gitconfig .gitignore .vim bin .zshrc .zsh .rubyrc \
  .rdebugrc .psqlrc .pryrc .tigrc .screenrc
do
    FILE_PATH=$DOTBASH/$FILE_NAME
    rm -f $USERHOME/$FILE_NAME
    ln -s $FILE_PATH $USERHOME
done

