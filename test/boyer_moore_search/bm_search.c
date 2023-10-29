#include <stdio.h>
#include <string.h>

#define NUM_OF_CHARS 256

int max(int a, int b) { return (a > b) ? a : b; }

void compute_array(char *pattern, int size, int arr[NUM_OF_CHARS])
{
    int i;

    for (i = 0; i < NUM_OF_CHARS; i++) arr[i] = -1;
    /* Fill the actual value of last occurrence of a character */
    for (i = 0; i < size; i++) arr[(int)pattern[i]] = i;
}

/* Boyer Moore Search algorithm  */
int boyer_moore_search(char *str, char *pattern)
{
    int answer = 1; // for test
    int n = strlen(str);
    int m = strlen(pattern);
    int shift = 0;
    int arr[NUM_OF_CHARS];

    compute_array(pattern, m, arr);
    while (shift <= (n - m))
    {
        int j = m - 1;
        while (j >= 0 && pattern[j] == str[shift + j]) j--;
        if (j < 0)
        {
            // printf("[DEBUG] Pattern is found at: %d\n", shift);
            answer *= shift; // for test
            shift += (shift + m < n) ? m - arr[str[shift + m]] : 1;
        }
        else
        {
            shift += max(1, j - arr[str[shift + j]]);
        }
    }
    
    // for test
    if (answer == 1)
        return -1;
    else
        return answer;
}