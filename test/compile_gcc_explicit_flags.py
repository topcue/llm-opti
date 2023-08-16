import os
import sys
import subprocess

##! TODO: generalize me
WORK_DIR = "/home/topcue/llm-opti"
GCC_PATH = f"{WORK_DIR}/tools/install/bin/gcc"

##! o1 flags
# flags = ["-fauto-inc-dec", "-fbranch-count-reg", "-fcombine-stack-adjustments", "-fcompare-elim", "-fcprop-registers", "-fdce", "-fdefer-pop", "-fdelayed-branch", "-fdse", "-fforward-propagate", "-fguess-branch-probability", "-fif-conversion", "-fif-conversion2", "-finline-functions-called-once", "-fipa-modref", "-fipa-profile", "-fipa-pure-const", "-fipa-reference", "-fipa-reference-addressable", "-fmerge-constants", "-fmove-loop-invariants", "-fomit-frame-pointer", "-freorder-blocks", "-fshrink-wrap", "-fshrink-wrap-separate", "-fsplit-wide-types", "-fssa-backprop", "-fssa-phiopt", "-ftree-bit-ccp", "-ftree-ccp", "-ftree-ch", "-ftree-coalesce-vars", "-ftree-copy-prop", "-ftree-dce", "-ftree-dominator-opts", "-ftree-dse", "-ftree-forwprop", "-ftree-fre", "-ftree-phiprop", "-ftree-pta", "-ftree-scev-cprop", "-ftree-sink", "-ftree-slsr", "-ftree-sra", "-ftree-ter", "-funit-at-a-time"]

##! o2 flags
# flags = ["-falign-functions", "-falign-jumps", "-falign-labels", "-falign-loops", "-fcaller-saves", "-fcode-hoisting", "-fcrossjumping", "-fcse-follow-jumps", "-fcse-skip-blocks", "-fdelete-null-pointer-checks", "-fdevirtualize", "-fdevirtualize-speculatively", "-fexpensive-optimizations", "-fgcse", "-fgcse-lm", "-fhoist-adjacent-loads", "-finline-small-functions", "-findirect-inlining", "-fipa-bit-cp", "-fipa-cp", "-fipa-icf", "-fipa-ra", "-fipa-sra", "-fipa-vrp", "-fisolate-erroneous-paths-dereference", "-flra-remat", "-foptimize-sibling-calls", "-foptimize-strlen", "-fpartial-inlining", "-fpeephole2", "-freorder-blocks-algorithm=stc", "-freorder-blocks-and-partition", "-freorder-functions", "-frerun-cse-after-loop", "-fschedule-insns", "-fschedule-insns2", "-fsched-interblock", "-fsched-spec", "-fstore-merging", "-fstrict-aliasing", "-fthread-jumps", "-ftree-builtin-call-dce", "-ftree-pre", "-ftree-switch-conversion", "-ftree-tail-merge", "-ftree-vrp"]

##! o3 flags
flags = ["-fgcse-after-reload", "-finline-functions", "-fipa-cp-clone", "-floop-interchange", "-floop-unroll-and-jam", "-fpeel-loops", "-fpredictive-commoning", "-fsplit-paths", "-ftree-loop-distribute-patterns", "-ftree-loop-distribution", "-ftree-loop-vectorize", "-ftree-partial-pre", "-ftree-slp-vectorize", "-funswitch-loops", "-fvect-cost-model", "-fversion-loops-for-strides"]

##! ofast
# flags = ["-ffast-math", "-fno-protect-parens"]

def compare_files(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        content1 = f1.read()
        content2 = f2.read()
    return content1 == content2

def compiler_with_optmz_level(target_dir, target, level):
    cmd_assemble = f"{GCC_PATH} -S {target_dir}/{target}.c -masm=intel -o {target_dir}/o{level}.s -O{level}"
    cmd_compile = f"{GCC_PATH} -c {target_dir}/o{level}.s -o {target_dir}/o{level}.o"
    cmd_archive = f"ar rcs {target_dir}/libo{level}.a {target_dir}/o{level}.o"
    cmd_link = f"{GCC_PATH} {target_dir}/{target}_driver.c -L {target_dir} -lo{level} -o {target}/{target}_driver_o{level}.elf"
    cmd_cleanup = f"rm {target_dir}/o{level}.o {target_dir}/libo{level}.a"

    subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_compile, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_archive, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_link, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    subprocess.run(cmd_cleanup, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)


def main():
    # target = "fibonacci"
    target = "quicksort"
    target_dir = target

    ##! compile w/ optmz level
    compiler_with_optmz_level(target_dir, target, 0)
    compiler_with_optmz_level(target_dir, target, 1)
    compiler_with_optmz_level(target_dir, target, 2)
    compiler_with_optmz_level(target_dir, target, 3)

    for flag in flags:
        output = "gcc_" + flag[1:]
        ##! TODO: generalize below line (-O2)
        cmd_assemble = f"{GCC_PATH} -S {target_dir}/{target}.c -masm=intel -o {target_dir}/{output}.s -O2 {flag}"
        print(cmd_assemble)
        subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)

        ##! TODO: generalize below line (o2.s)
        print(f"{target_dir}/{output}.s")
        identical = compare_files(f"{target_dir}/o2.s", f"{target_dir}/{output}.s")
        print(identical)
        if identical:
            os.system(f"rm {target_dir}/{output}.s")
            pass
        else:
            print("[*]", flag)
            cmd_assemble = f"{GCC_PATH} -c {target_dir}/{output}.s -o {target_dir}/{output}.o"
            cmd_compile = f"{GCC_PATH} -c {target_dir}/{output}.s -o {target_dir}/{output}.o"
            cmd_archive = f"ar rcs {target_dir}/lib{output}.a {target_dir}/{output}.o"
            cmd_link = f"{GCC_PATH} {target_dir}/{target}_driver.c -L {target_dir} -l{output} -o {target}/{target}_driver_{output}.elf"
            cmd_cleanup = f"rm {target_dir}/{output}.o {target_dir}/lib{output}.a"

            subprocess.run(cmd_assemble, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
            subprocess.run(cmd_compile, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
            subprocess.run(cmd_archive, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
            subprocess.run(cmd_link, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
            subprocess.run(cmd_cleanup, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, check=True)
    pass


main()

# EOF
