DIR=$(dirname $0)

DOTBASH=$HOME/.dotbash

[ -d $DOTBASH ] || ln -s $DIR $DOTBASH

for FILE_NAME in .bashrc .bash_aliases .irbrc .gemrc .gitconfig .gitignore
do
    FILE_PATH=$DOTBASH/$FILE_NAME
    rm -f $HOME/$FILE_NAME
    ln -s $FILE_PATH $HOME
done
