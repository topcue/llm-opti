#!/bin/bash

# gcc -S quicksort.c -masm=intel -o tmp.s -O2

gcc -c tmp.s -o tmp.o
ar rcs libtmp.a tmp.o
gcc quicksort_driver.c -o quicksort_driver_tmp.elf -L. -ltmp

time ./quicksort_driver_tmp.elf test
time ./quicksort_driver_tmp.elf bench

