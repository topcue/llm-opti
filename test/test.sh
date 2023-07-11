#!/bin/bash

##! TODO_BLOCK
: '
Last week, I tested by overwriting all the input/output assembly codes of GPT to
fibonacci.s. Think of a sensible way to store all the processes as assembly code
with different names.

In the current research process, it seems that it is not at a stage to apply
various optimization strategies while considering dependencies. Therefore, there
will be no big problem if we just overwrite an assembly code file yet.
(Not an urgent problem)
'

file_exists() {
    if [[ $# -eq 0 ]] ; then
        echo "[-] Usage: $0 target_program"
        exit 1
    else
        echo "[*] Target program: $1"

        dir="$1"
        target="$1"
        assembly_code="${dir}/${target}.s"
        driver_code="${dir}/${target}_driver.c"

        if [ ! -e $assembly_code ] || [ ! -e $driver_code ]; then
            echo "[-] At least one of the assembly code or driver code does not exist."
            exit 1
        fi
    fi
}

compile() {
    dir="$1"
    target="$1"

    ##! Assemble the code into an object file
    assembly_code="${dir}/${target}.s"
    object_file="${dir}/${target}.o"
    gcc -c $assembly_code -o $object_file

    ##! Archive the object file into a static library
    library="${dir}/lib${target}.a"
    ar rcs $library $object_file

    ##! Compile the driver code and link a static library
    driver_code="${dir}/${target}_driver.c"
    driver_program="${dir}/${target}_driver.elf"
    gcc $driver_code -o $driver_program -L ${dir} "-l${target}"
}

driver() {
    dir="$1"
    target="$1"
    driver_program="${dir}/${target}_driver.elf"

    if [ $2 = "test" ]; then
        $driver_program test
    elif [ $2 = "bench" ]; then
        time $driver_program bench
    fi
}


TARGET="$1"

file_exists $TARGET
compile $TARGET

##! TODO: Fix asserts about arguments to be more concise
if [ $# -lt 2 ]; then
    mode="test"
else
    mode="$2"
fi

if [ "${mode}" = "test" ]; then
    driver $TARGET "test"
elif [ "${mode}" = "bench" ]; then
    driver $TARGET "bench"
else
    echo "[-] Unknown argument: ${mode}"
    exit 1
fi

# EOF
