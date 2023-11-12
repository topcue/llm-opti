import os

HOME_PATH = os.path.expanduser('~')
GCC_PATH = f"{HOME_PATH}/llm-opti/tools/install/bin/gcc"
AR_PATH = f"{HOME_PATH}/llm-opti/tools/install/bin/gcc-ar"


def compile():
    # tmp1 = f"{GCC_PATH} -S program_bench.c -masm=intel -o tmp.s -O0 1>/dev/null"

    tmp2 = f"{GCC_PATH} -c tmp.s -o tmp.o 1>/dev/null"
    tmp3 = f"{AR_PATH} rcs libtmp.a tmp.o 1>/dev/null"
    tmp4 = f"{GCC_PATH} program_driver.c -O0 -o program_driver.elf -L. -ltmp 1>/dev/null"

    # for test
    tmp5 = f"{GCC_PATH} program_driver_print.c -O0 -o program_driver_print.elf -L. -ltmp 1>/dev/null"

    # os.system(tmp1)
    os.system(tmp2)
    os.system(tmp3)
    os.system(tmp4)
    os.system(tmp5)


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
    arr = []
    for _ in range(10):
        # cmd1 = "start=\"$(date +'%s.%N')\""
        # cmd2 = "./program_driver.elf < test-cases/test-case-1.in"
        # cmd3 = "echo \"$(date +\"%s.%N - ${start}\" | bc)\" >&2"
        
        # t = os.popen(f"{cmd1};{cmd2};{cmd3}").read().strip()

        # t = os.popen(f"sudo nice -n -19 taskset 1 ./program_driver.elf < test-cases/test-case-1.in").read().strip()
        t = os.popen(f"taskset 1 ./program_driver.elf < test-cases/test-case-1.in").read().strip()
        t = t.replace("[+] ", "")
        t = t.replace(" cycles", "")

        print(t)
        arr.append(float(t))

    print(sorted(arr))
    avg = round(sum(arr) / len(arr), 4)
    print(avg)
    # print(max(arr) - min(arr))


def main():
    compile()
    test()
    benchmark()


if __name__ == "__main__":
    main()

# EOF
