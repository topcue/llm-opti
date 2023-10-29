/*  Problem Statement: https://codeforces.com/problemset/problem/393/A
 *  Author: striker
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "program_bench.h"

#define STRING_MAX_LENGTH 101
#define MAX_NUMBER_OF_NINETEEN 14
#define NOT_FOUND -1
#define FIND_MIN(a, b) ((a) > (b)) ? (b) : (a)

static int binary_search_integers(const int *const, const int);
static int find_largest_element_smaller_than_n(const int *const, const int);

int main(void) {
    char string_data[STRING_MAX_LENGTH];
    scanf("%s", string_data);
    for (int i = 0; i < 5000000; i++)
        func1(string_data);
    return EXIT_SUCCESS;
}