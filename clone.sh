DIR=/home/bogdan/.dotbash 
rm -rf $DIR
mkdir -p $DIR
git clone https://github.com/bogdan/dotbash.git $DIR
cd $DIR
./install.sh
