# Modify the variable to desired Mellanox OFED version
MOFED_VERSION=4.7-1.0.0.1
# Modify the variable to desired OS
MOFED_OS=ubuntu18.04
pushd /tmp
curl -fSsL https://www.mellanox.com/downloads/ofed/MLNX_OFED-${MOFED_VERSION}/MLNX_OFED_LINUX-${MOFED_VERSION}-${MOFED_OS}-x86_64.tgz | tar -zxpf -
cd MLNX_OFED_LINUX-*
sudo ./mlnxofedinstall
popd
