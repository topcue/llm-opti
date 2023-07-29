#!/bin/bash

##! Notice: this is temp build script!!

## download git repo
git clone git://gcc.gnu.org/git/gcc.git

## checkout gcc-11.3.0
cd gcc && git checkout releases/gcc-11.3.0

## configure and make all
../configure --prefix="/home/${USER}/llm-opti/tools/install"
make -j 8 && make install

## patch and remake
cd llm-opti/tools/gcc
git apply llm-opti/tools/patches/my_changes.patch

# EOF
