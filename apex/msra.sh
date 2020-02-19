# mismatched version between cuda and pytorch
# cuda verision: /usr/local/cuda/bin/nvcc --version (nvcc -V is wrong) or ls /user/etc | grep cuda
# => torch.version.cuda


sudo pip3 uninstall torch torchvision
sudo pip3 install torch==1.4+cu100 torchvision==0.5.0+cu100 -f https://download.pytorch.org/whl/torch_stable.html
# cd apex; rm -rf build

git clone https://github.com/NVIDIA/apex.git
cd apex
sudo pip3 install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--deprecated_fused_adam" ./
