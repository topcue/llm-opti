#include <stdint.h>

#define NUM_ITERATION 10000000

uint64_t rdtsc() {
    unsigned int low, high;
    asm volatile("rdtsc" : "=a" (low), "=d" (high));
    return ((uint64_t)high << 32) | low;
}

void func1(char* string1, char* string2);