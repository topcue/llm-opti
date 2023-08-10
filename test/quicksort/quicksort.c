// https://www.programiz.com/dsa/quick-sort

// Quick sort in C

#include <stdio.h>

void func1(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

int func2(int array[], int low, int high) {    
    int pivot = array[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
        if (array[j] <= pivot) {
            i++;
            func1(&array[i], &array[j]);
        }
    }
    func1(&array[i + 1], &array[high]);
    return (i + 1);
}

void func3(int array[], int low, int high) {
    if (low < high) {
        int pi = func2(array, low, high);
        func3(array, low, pi - 1);
        func3(array, pi + 1, high);
    }
}

// EOF
