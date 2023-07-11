import os
import sys

##! o2 flags
flags = ["-falign-functions", "-falign-jumps", "-falign-labels", "-falign-loops", "-fcaller-saves", "-fcode-hoisting", "-fcrossjumping", "-fcse-follow-jumps", "-fcse-skip-blocks", "-fdelete-null-pointer-checks", "-fdevirtualize", "-fdevirtualize-speculatively", "-fexpensive-optimizations", "-fgcse", "-fgcse-lm", "-fhoist-adjacent-loads", "-finline-small-functions", "-findirect-inlining", "-fipa-bit-cp", "-fipa-cp", "-fipa-icf", "-fipa-ra", "-fipa-sra", "-fipa-vrp", "-fisolate-erroneous-paths-dereference", "-flra-remat", "-foptimize-sibling-calls", "-foptimize-strlen", "-fpartial-inlining", "-fpeephole2", "-freorder-blocks-algorithm=stc", "-freorder-blocks-and-partition", "-freorder-functions", "-frerun-cse-after-loop", "-fschedule-insns", "-fschedule-insns2", "-fsched-interblock", "-fsched-spec", "-fstore-merging", "-fstrict-aliasing", "-fthread-jumps", "-ftree-builtin-call-dce", "-ftree-pre", "-ftree-switch-conversion", "-ftree-tail-merge", "-ftree-vrp"]

##! o3 flags
# flags = ["-fgcse-after-reload", "-finline-functions", "-fipa-cp-clone", "-floop-interchange", "-floop-unroll-and-jam", "-fpeel-loops", "-fpredictive-commoning", "-fsplit-paths", "-ftree-loop-distribute-patterns", "-ftree-loop-distribution", "-ftree-loop-vectorize", "-ftree-partial-pre", "-ftree-slp-vectorize", "-funswitch-loops", "-fvect-cost-model", "-fversion-loops-for-strides"]

##! ofast
# flags = ["-ffast-math", "-fno-protect-parens"]

def compare_files(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        content1 = f1.read()
        content2 = f2.read()
    return  content1 == content2

def compiler_with_optmz_level(target_dir, target, level):
    os.system(f"gcc -S {target_dir}/{target}.c -masm=intel -o {target_dir}/o{level}.s -O{level}")
    os.system(f"gcc -c {target_dir}/o{level}.s -o {target_dir}/o{level}.o")
    os.system(f"ar rcs {target_dir}/libo{level}.a {target_dir}/o{level}.o")
    os.system(f"gcc {target_dir}/{target}_driver.c -L {target_dir} -lo{level} -o {target}/{target}_driver_o{level}.elf")

    os.system(f"rm {target_dir}/libo{level}.a")


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
        ##! TODO: generalize below line (-O1)
        os.system(f"gcc -S {target_dir}/{target}.c -masm=intel -o {target_dir}/{output}.s -O1 {flag}")

        ##! TODO: generalize below line (o1.s)
        identical = compare_files(f"{target_dir}/o1.s", f"{target_dir}/{output}.s")
        if identical:
            os.system(f"rm {target_dir}/{output}.s")
        else:
            print("[*]", flag)
            os.system(f"gcc -c {target_dir}/{output}.s -o {target_dir}/{output}.o")
            os.system(f"ar rcs {target_dir}/lib{output}.a {target_dir}/{output}.o")
            os.system(f"gcc {target_dir}/{target}_driver.c -L {target_dir} -l{output} -o {target}/{target}_driver_{output}.elf")

            os.system(f"rm {target_dir}/lib{output}.a")

            

main()

# EOF
