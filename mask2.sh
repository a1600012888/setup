#cd /rscratch/tyz/
#conda activate maskrcnn_benchmark
conda install ipython
pip install ninja yacs cython matplotlib tqdm opencv-python --user
pip install protobuf pillow --user

export INSTALL_DIR=$PWD
cd cocoapi/PythonAPI
rm -rf build/
python setup.py build_ext install

cd $INSTALL_DIR
cd apex
rm -rf build/
python setup.py install --cuda_ext --cpp_ext

cd $INSTALL_DIR
# git clone https://github.com/facebookresearch/maskrcnn-benchmark.git
cd maskrcnn-benchmark

rm -rf build/
python setup.py build develop


unset INSTALL_DIR
