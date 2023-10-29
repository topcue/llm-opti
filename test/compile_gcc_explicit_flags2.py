import os
import sys
import subprocess

##! TODO: Generalize path
WORK_DIR = "/home/topcue/llm-opti"
GCC_PATH = f"{WORK_DIR}/tools/install/bin/gcc"
AR_PATH = f"{WORK_DIR}/tools/install/bin/gcc-ar"

##! GCC explicit optimization passes
O0_FLAGS = []
O1_FLAGS = ["-fauto-inc-dec", "-fbranch-count-reg", "-fcombine-stack-adjustments", "-fcompare-elim", "-fcprop-registers", "-fdce", "-fdefer-pop", "-fdelayed-branch", "-fdse", "-fforward-propagate", "-fguess-branch-probability", "-fif-conversion", "-fif-conversion2", "-finline-functions-called-once", "-fipa-modref", "-fipa-profile", "-fipa-pure-const", "-fipa-reference", "-fipa-reference-addressable", "-fmerge-constants", "-fmove-loop-invariants", "-fomit-frame-pointer", "-freorder-blocks", "-fshrink-wrap", "-fshrink-wrap-separate", "-fsplit-wide-types", "-fssa-backprop", "-fssa-phiopt", "-ftree-bit-ccp", "-ftree-ccp", "-ftree-ch", "-ftree-coalesce-vars", "-ftree-copy-prop", "-ftree-dce", "-ftree-dominator-opts", "-ftree-dse", "-ftree-forwprop", "-ftree-fre", "-ftree-phiprop", "-ftree-pta", "-ftree-scev-cprop", "-ftree-sink", "-ftree-slsr", "-ftree-sra", "-ftree-ter", "-funit-at-a-time"]
O2_FLAGS = ["-falign-functions", "-falign-jumps", "-falign-labels", "-falign-loops", "-fcaller-saves", "-fcode-hoisting", "-fcrossjumping", "-fcse-follow-jumps", "-fcse-skip-blocks", "-fdelete-null-pointer-checks", "-fdevirtualize", "-fdevirtualize-speculatively", "-fexpensive-optimizations", "-fgcse", "-fgcse-lm", "-fhoist-adjacent-loads", "-finline-small-functions", "-findirect-inlining", "-fipa-bit-cp", "-fipa-cp", "-fipa-icf", "-fipa-ra", "-fipa-sra", "-fipa-vrp", "-fisolate-erroneous-paths-dereference", "-flra-remat", "-foptimize-sibling-calls", "-foptimize-strlen", "-fpartial-inlining", "-fpeephole2", "-freorder-blocks-algorithm=stc", "-freorder-blocks-and-partition", "-freorder-functions", "-frerun-cse-after-loop", "-fschedule-insns", "-fschedule-insns2", "-fsched-interblock", "-fsched-spec", "-fstore-merging", "-fstrict-aliasing", "-fthread-jumps", "-ftree-builtin-call-dce", "-ftree-pre", "-ftree-switch-conversion", "-ftree-tail-merge", "-ftree-vrp"]
O3_FLAGS = ["-fgcse-after-reload", "-finline-functions", "-fipa-cp-clone", "-floop-interchange", "-floop-unroll-and-jam", "-fpeel-loops", "-fpredictive-commoning", "-fsplit-paths", "-ftree-loop-distribute-patterns", "-ftree-loop-distribution", "-ftree-loop-vectorize", "-ftree-partial-pre", "-ftree-slp-vectorize", "-funswitch-loops", "-fvect-cost-model", "-fversion-loops-for-strides"]

def compare_files(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        content1 = f1.read()
        content2 = f2.read()
    return content1 == content2

def compiler_with_optmz_level(target, level):
    cmd_assemble = f"{GCC_PATH} -S {target}/program_bench.c -masm=intel -o {target}/o{level}.s -O{level}"
    cmd_compile = f"{GCC_PATH} -c {target}/o{level}.s -o {target}/o{level}.o"
    cmd_archive = f"{AR_PATH} rcs {target}/libo{level}.a {target}/o{level}.o"
    cmd_link = f"{GCC_PATH} {target}/program_driver.c -L {target} -lo{level} -o {target}/program_driver_o{level}.elf"
    cmd_cleanup = f"rm {target}/o{level}.o {target}/libo{level}.a {target}/program_driver_o{level}.elf"

    subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_compile, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_archive, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_link, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_cleanup, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)


def main():
    target = "boy_or_girl"
    target = "dangerous_team"
    target = "distinct_digit_year"
    target = "lexicographic_string_comparison"
    target = "nineteen"
    target = "watermelon"
    

    flags_list = [O0_FLAGS, O1_FLAGS, O2_FLAGS, O3_FLAGS]

    for opti_level in [0, 1, 2, 3]:
        print("[DEBUG] opti_level:", opti_level)

        ##! compile w/ optmz level
        compiler_with_optmz_level(target, opti_level)

        flags = flags_list[opti_level]
        for flag in flags:
            output = "gcc_" + flag[1:]
            ##! TODO: generalize below line (-O1)
            cmd_assemble = f"{GCC_PATH} -S {target}/program_bench.c -masm=intel -o {target}/{output}.s -O0 {flag}"
            subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)

            ##! TODO: generalize below line (o1.s)
            identical = compare_files(f"{target}/o0.s", f"{target}/{output}.s")
            if identical:
                os.system(f"rm {target}/{output}.s")
            else:
                print("[*]", flag)
                cmd_assemble = f"{GCC_PATH} -c {target}/{output}.s -o {target}/{output}.o"
                cmd_compile = f"{GCC_PATH} -c {target}/{output}.s -o {target}/{output}.o"
                cmd_archive = f"{AR_PATH} rcs {target}/lib{output}.a {target}/{output}.o"
                cmd_link = f"{GCC_PATH} {target}/program_driver.c -L {target} -l{output} -o {target}/program_driver_{output}.elf"
                cmd_cleanup = f"rm {target}/{output}.o {target}/lib{output}.a {target}/program_driver_{output}.elf"

                subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
                subprocess.run(cmd_compile, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
                subprocess.run(cmd_archive, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
                subprocess.run(cmd_link, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
                subprocess.run(cmd_cleanup, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)


main()

# EOF
