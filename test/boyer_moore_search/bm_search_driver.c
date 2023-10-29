#include <stdio.h>
#include <string.h>
#include <assert.h>

int boyer_moore_search(char *str, char *pattern);

void test1() {
    // int data[] = {8, 7, 2, 1, 0, 9, 6};
    // int answer[7] = {0, 1, 2, 6, 7, 8, 9};
    // int n = sizeof(data) / sizeof(data[0]);

    // // perform quicksort on data
    // func3(data, 0, n - 1);
    // for (size_t i = 0; i < 7; i++) {
    //     assert(data[i] == answer[i]);
    // }

    char str[] = "AABCAB12AFAABCABFFEGABCAB";
    char pat1[] = "ABCAB";
    char pat2[] = "FFF"; /* not found */
    char pat3[] = "CAB";

    // pat1: 220 (1, 11, 20)
    // pat2: -1 (X)
    // pat3: 858 (3, 13, 22)
    assert(boyer_moore_search(str, pat1) == 220);
    assert(boyer_moore_search(str, pat2) == -1);
    assert(boyer_moore_search(str, pat3) == 858);
}

void test2() {
    return;
}

void benchmark() {
    char str[] = "AABCAB12AFAABCABFFEGABCAB";
    char pat1[] = "ABCAB";
    char pat2[] = "FFF"; /* not found */
    char pat3[] = "CAB";
    
    for (size_t i = 0; i < 50000000; i++) {
        boyer_moore_search(str, pat1);
    }
}


int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <mode>\n", argv[0]);
        return 1;
    }

    char* mode = argv[1];
    if (strcmp(mode, "test") == 0) {
        printf("[DEBUG] test mode\n");
        void (*tests[])(void) = {test1, test2};
        int num_tests = sizeof(tests) / sizeof(tests[0]);
        for (int i = 0; i < num_tests; i++) {
            tests[i]();
        }
        printf("[+] bm_search driver: passed test!\n");
    } else if (strcmp(mode, "bench") == 0) {
        printf("[DEBUG] benchmark mode\n");
        benchmark();
    } else {
        printf("Unknown mode: %s\n", mode);
        printf("Usage: %s <mode>\n", argv[0]);
        return 1;
    }

    return 0;
}