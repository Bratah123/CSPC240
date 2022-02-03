/*
  Author: Brandon
  C++ driver for the assembly code
*/
#include <iostream>

extern "C" long int testmodule();

int main(int argc, char* argv[]) {
  printf("This program will ask for two integers and return the sum of the two numbers.\n");
  testmodule();
  printf("\nEnd of demonstration test.\n");
  return 0;
}
