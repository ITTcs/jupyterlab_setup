#!/bin/sh

v=3.7.1

sudo apt update
sudo apt install -y --no-install-recommends \
gcc \
libbz2-dev \
libffi-dev \
libgdbm-dev \
liblzma-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
tk-dev \
uuid-dev

wget https://www.python.org/ftp/python/$v/Python-$v.tar.xz
tar -xf ./Python-$v.tar.xz
cd Python-$v
./configure
make -j $(nproc)
sudo make altinstall
cd ..
rm ./Python-$v.tar.xz
sudo rm -rf ./Python-$v
