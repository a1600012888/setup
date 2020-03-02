
# blob

sudo apt install python3-pip

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

echo copying models

mkdir ~/models
cp ~/container/v-tianyz/models/SE-F-SE-F-16-roberta_base-03768-p512-b256-20w.pt  ./models
cp ~/container/v-tianyz/models/SE-F-SE-AVG-16-roberta_base-03768-p512-b256-20w.pt ./models
cp ~/container/v-tianyz/models/baseline-roberta_base-03768-p512-b256-20w.pt ./models
cp ~/container/v-tianyz/models/masker-Robera-base-masker-32768-p512-b256-c0.0001-20w.pt ./models
cp ~/container/v-tianyz/models/masker-Robera-base-masker-32768-p512-b256-c0.00003-20w.pt ./models


bash ms_lib.sh


cd ~

git clone https://github.com/a1600012888/fairseq.git
cd fairseq
pip3 install --editable .
