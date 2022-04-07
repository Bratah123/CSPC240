// Author: Brandon P. Nguyen
// CWID: 887028942
// Section: CPSC 240-09
// Email: brandonnguyen3301@csu.fullerton.edu
// Purpose:
#include <iostream>
#include <cstdio>
#include <stdio.h>

// change return type to whatever is needed
extern "C" double get_electricity();
extern "C" void show_electricity(double value, double value2);
extern "C" bool verify_float(char w[]);
extern "C" void show_power(double work);

int main()
{
    printf("This is a midterm program made by Brandon N. for CPSC240-09\n\n");

    double work_number = get_electricity();

    printf("\nAmpere received this unrecognized value %lf and will keep it.\n", work_number);
    printf("Zero will be returned to the OS. Bye\n");

    return 0;
}

void show_electricity(double volts, double ohms) {
  printf("\nYou have entered\n%lf volts\n%lf ohms\n", volts, ohms);
}

void show_power(double work) {
  printf("\nThe work being performed is %lf Joules\n\n", work);
}

bool verify_float(char w[]) {
  // Function that returns true if a given string is a proper float number
	bool result       = true;
	int  index        = 0;
	bool decimalFound = false;

	if(w[0]=='-'|| w[0=='+']) index = 1;

	while(!(w[index] == '\0') && result) {
		if(w[index] == '.' && !decimalFound) decimalFound = true;

		else result = result && isdigit(w[index]);

		index++;
	}
	return result && decimalFound;
}
