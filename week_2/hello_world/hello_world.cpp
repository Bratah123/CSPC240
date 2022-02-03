/*
  Author: Brandon
  C++ driver for the assembly code
*/
#include <iostream>

extern "C" long int testmodule();

int main(int argc, char* argv[]) {
  printf("This program will print hello world from an assembly module.\n");
  testmodule();
  printf("End of assembly module.\n");
  printf("End of demonstration test.\n");
  return 0;
}
