import os
import subprocess
from re import findall

base_folder = 'Competitive-Programming/Code-Forces/'
test_input = 'test-cases/test-case-1.in'
save_dir = 'bench/'
optimizations = ['-O0', '-O1', '-O2', '-O3', '-Ofast']

#logging.basicConfig(filename=save_dir+'bench.log', level=logging.WARNING)

def bench_time(filename, testcase):
    cmd = f'perf stat {filename} < {testcase}' # no dry run
    #print(cmd)
    while True:
        p = subprocess.run(cmd, capture_output=True, text=True, shell=True)
        
        if p.returncode:
            print(f'bench error {filename}')
            #print(p.stdout)
            return 0
        # print(p.stderr)
        found = float(findall('\d+\.\d+ seconds user', p.stderr)[0].split(' ')[0])
        #print(found * 1000)
        if found != 0.0:
            break
    return found * 1000

def bench(path, cache=False):
    # gen bench folder
    if not os.path.exists(save_dir):
        os.mkdir(save_dir)
    
    # find first-fit c file in folder
    c_filename = ''
    for filename in os.listdir(path):
        filename = os.path.join(path, filename)

        if not os.path.isfile(filename):
            continue
        
        if filename.endswith('.c'):
            c_filename = filename
            testcase_filename = path + '/test-cases/test-case-1.in'
            break
    
    if not c_filename:
        #logging.warning(f'{path} does not have c file.')
        #print(f'{path} does not have c file.')
        return None
    
    # make bench dir
    bench_dir = save_dir + os.path.basename(c_filename)[:-2]
    if not os.path.exists(bench_dir):
        os.mkdir(bench_dir)
    bench_results = []
    for optim in optimizations:
        bin_filename = os.path.join(bench_dir, os.path.basename(c_filename)[:-2] + f'{optim}.bin')
        if cache and not os.path.exists(bin_filename):
            os.system(f'gcc -w {optim} -o {bin_filename} {c_filename}')
        #print(f'gcc {optim} -o {bin_filename} {c_filename}')
        bench_results.append(bench_time(bin_filename, testcase_filename))
    
    return bench_results
    

if __name__=="__main__":

    for filename in os.listdir(base_folder):
        prob_folder = os.path.join(base_folder, filename)
        
        # only subfolder
        if os.path.isfile(prob_folder):
            continue
        
        # avg results
        res = [0.0 for _ in range(5)]
        loop_cnt = 10
        for _ in range(loop_cnt):
            tmp = bench(prob_folder, cache=True)
            if not tmp:
                break
            for i in range(5):
                res[i] += tmp[i]
        if not tmp:
            continue
        for i in range(5):
            res[i] = round(res[i] / loop_cnt, 3)
        print(prob_folder, res)
        #exit(0)
