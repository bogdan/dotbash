
DOTBASH=$HOME/.dotbash

[ -d $DOTBASH ] || ln -s `pwd` $DOTBASH

for FILE_NAME in .bashrc .bash_aliases .irbrc .gemrc .gitconfig .gitignore .vim bin .zshrc .zsh .rubyrc .rdebugrc .psqlrc .pryrc
do
    FILE_PATH=$DOTBASH/$FILE_NAME
    rm -f $HOME/$FILE_NAME
    ln -s $FILE_PATH $HOME
done

