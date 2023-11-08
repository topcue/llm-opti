#include <stdint.h>

#define NUM_ITERATION 5000000

uint64_t rdtsc() {
    unsigned int low, high;
    asm volatile("rdtsc" : "=a" (low), "=d" (high));
    return ((uint64_t)high << 32) | low;
}

int func1(char* binary_string);