#include <stdio.h>
#include <string.h>
#include <assert.h>

void func1(int *a, int *b);
int func2(int array[], int low, int high);
void func3(int array[], int low, int high);

void test1() {
    int data[] = {8, 7, 2, 1, 0, 9, 6};
    int answer[7] = {0, 1, 2, 6, 7, 8, 9};
    int n = sizeof(data) / sizeof(data[0]);

    // perform quicksort on data
    func3(data, 0, n - 1);
    for (size_t i = 0; i < 7; i++) {
        assert(data[i] == answer[i]);
    }
}

void test2() {
    return;
}

void benchmark() {
    int data[13] = {8, 7, 2, 1, 0, 9, 6, 4, 4, 3, 5, 10, -1};
    int temp[13] = {0, };

    for (size_t i = 0; i < 200000000; i++) {
        memcpy(temp, data, sizeof(int) * 13);
        func3(temp, 0, 7);
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
        printf("[+] quicksort driver: passed test!\n");
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

// EOF
