#include <stdint.h>

#define NUM_ITERATION 1000000

uint64_t rdtsc() {
    unsigned int low, high;
    asm volatile("rdtsc" : "=a" (low), "=d" (high));
    return ((uint64_t)high << 32) | low;
}

bool func1(int n);
int func2(const int year);