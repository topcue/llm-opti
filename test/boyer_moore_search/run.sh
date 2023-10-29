#!/bin/bash

GCC_PATH="${HOME}/llm-opti/tools/install/bin/gcc"
AR_PATH="${HOME}/llm-opti/tools/install/bin/gcc-ar"

${GCC_PATH} -S bm_search.c -masm=intel -o tmp.s -O0
# ${GCC_PATH} -S bm_search_strip.c -masm=intel -o tmp.s -O1

${GCC_PATH} -c tmp.s -o tmp.o
${AR_PATH} rcs libtmp.a tmp.o
${GCC_PATH} bm_search_driver.c -O0 -o bm_search_driver_tmp.elf -L. -ltmp
# ${GCC_PATH} bm_search_driver_strip.c -O0 -o bm_search_driver_tmp.elf -L. -ltmp

time ./bm_search_driver_tmp.elf test
time ./bm_search_driver_tmp.elf bench

rm -f tmp.o libtmp.a bm_search_driver_tmp.elf

# EOF

