#!/bin/bash

GCC_PATH="${HOME}/llm-opti/tools/install/bin/gcc"
AR_PATH="${HOME}/llm-opti/tools/install/bin/gcc-ar"

# ${GCC_PATH} -S quicksort.c -masm=intel -o tmp.s -O0
# ${GCC_PATH} -S quicksort_with_symbols.c -masm=intel -o tmp.s -O1

${GCC_PATH} -c tmp.s -o tmp.o
${AR_PATH} rcs libtmp.a tmp.o
# ${GCC_PATH} quicksort_driver.c -O0 -o quicksort_driver_tmp.elf -L. -ltmp
${GCC_PATH} quicksort_driver_with_symbols.c -O0 -o quicksort_driver_tmp.elf -L. -ltmp

time ./quicksort_driver_tmp.elf test
time ./quicksort_driver_tmp.elf bench

rm tmp.o libtmp.a quicksort_driver_tmp.elf

# EOF
