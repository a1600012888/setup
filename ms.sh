
# blob


wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install blobfuse

chmod 600 fuse_connection.cfg

mkdir ~/container

sudo blobfuse ~/container --tmp-path=/blob  --config-file=./fuse_connection.cfg  -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o allow_other


mkdir ~/data

echo copying data
cp -r ~/container/v-zhexu/wiki_book_32768 ~/data/
cp -r ~/container/v-zhexu/glue-32768-fast ~/data/


bash ms_lib.sh


cd ~

git clone https://github.com/a1600012888/fairseq.git
cd fairseq
pip3 install --editable .
