#!/bin/bash

##! Notice: this is temp build script!!

## download git repo
git clone git://gcc.gnu.org/git/gcc.git

## checkout gcc-11.3.0
cd gcc && git checkout releases/gcc-11.3.0

## configure and make all
mkdir -p build install; cd build
../configure --prefix="/home/${USER}/llm-opti/tools/install"
make -j 24 && make install

## patch
cd ${HOME}/llm-opti/tools/gcc
git apply /home/topcue/llm-opti/tools/patches/quick_sort_flags.patch

## rebuild
cd ${HOME}/llm-opti/tools/gcc/build
make -j 24 && make install

# EOF
