import os

HOME_PATH = os.path.expanduser('~')
GCC_PATH = f"{HOME_PATH}/llm-opti/tools/install/bin/gcc"
AR_PATH = f"{HOME_PATH}/llm-opti/tools/install/bin/gcc-ar"


def compile():
    cmd_compile = f"{GCC_PATH} -S program_bench.c -masm=intel -o tmp.s -O0 1>/dev/null"

    cmd_assemble = f"{GCC_PATH} -c tmp.s -o tmp.o 1>/dev/null"
    cmd_archive = f"{AR_PATH} rcs libtmp.a tmp.o 1>/dev/null"
    # for benchmark
    cmd_link_driver = f"{GCC_PATH} program_driver.c -O0 -o program_driver.elf -L. -ltmp 1>/dev/null"
    # for test
    cmd_link_tester = f"{GCC_PATH} program_driver_print.c -O0 -o program_driver_print.elf -L. -ltmp 1>/dev/null"

    # os.system(cmd_compile) # compile C code
    os.system(cmd_assemble)
    os.system(cmd_archive)
    os.system(cmd_link_driver)
    os.system(cmd_link_tester)


def test():
    test_cases_path = "test-cases"
    num_of_test_cases = len(os.listdir("test-cases")) // 2
    for i in range(1, num_of_test_cases+1):
        output = os.popen(f"./program_driver_print.elf < {test_cases_path}/test-case-{i}.in").read().strip()
        with open(os.path.join(test_cases_path, f"test-case-{i}.out"), 'r') as f:
            answer = f.readline().strip()
        if output != answer:
            print(f"[-] Failed test: test-case-{i}")
            exit(1)
    print("[+] Pass test")


def benchmark():
    cycles_results = []
    for _ in range(10):
        output = os.popen(f"sudo nice -n -19 taskset 1 ./program_driver.elf < test-cases/test-case-1.in").read().strip()
        cycles = output.replace("[+] ", "").replace(" cycles", "")

        print(cycles)
        cycles_results.append(float(cycles))
    cycles_results = cycles_results[1:-1]
    avg_cycles = round(sum(cycles_results) / len(cycles_results), 2)
    print(f"[+] avg_cycles: {avg_cycles}")


def cleanup():
    cmd_cleanup = f"rm tmp.o libtmp.a program_driver.elf program_driver_print.elf"
    os.system(cmd_cleanup)


def main():
    compile()
    test()
    benchmark()
    cleanup()


if __name__ == "__main__":
    main()

# EOF
