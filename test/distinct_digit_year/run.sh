#!/bin/bash

GCC_PATH="${HOME}/llm-opti/tools/install/bin/gcc"
AR_PATH="${HOME}/llm-opti/tools/install/bin/gcc-ar"

${GCC_PATH} -S program_bench.c -masm=intel -o tmp.s -O0

${GCC_PATH} -c tmp.s -o tmp.o
${AR_PATH} rcs libtmp.a tmp.o
${GCC_PATH} program_driver.c -O0 -o program_driver_tmp.elf -L. -ltmp

time ./program_driver_tmp.elf < test-cases/test-case-1.in

rm tmp.o libtmp.a program_driver_tmp.elf

# EOF
