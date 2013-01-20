#!/usr/bin/env sh

cd "$(dirname "$0")"
umask 022

sudo apt-get install git cmake python3-pip libpthread-stubs0-dev libgl1-mesa-dev \
                                libx11-dev libxrandr-dev libfreetype6-dev libglew-dev \
                                libjpeg8-dev libsndfile1-dev libopenal-dev

sudo pip-3.2 install cython

git clone git://github.com/bastienleonard/pysfml-cython.git
git clone git://github.com/LaurentGomila/SFML.git

cd SFML
cmake -G "Unix Makefiles"
make
sudo make install
sudo ldconfig

cd ../pysfml-cython
python3 setup3k.py build_ext || (python3 patch.py && python3 setup3k.py build_ext)
sudo python3 setup3k.py install

