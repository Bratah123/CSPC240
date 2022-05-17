// Author: Brandon P. Nguyen
// CWID: 887028942
// Section: CPSC 240-09
// Email: brandonnguyen3301@csu.fullerton.edu
#include <iostream>
#include <cstdio>
#include <stdio.h>

// change return type to whatever is needed
extern "C" double resistance();

int main()
{
    printf("Welcome to the Electric Resistance Program by Brandon P. Nguyen\n\n");

    double total_resistance = resistance();

    printf("The caller received this number %lf and will keep it.\n", total_resistance);
    printf("A zero will be sent to the OS as a signal of success.\n");

    return 0;
}
