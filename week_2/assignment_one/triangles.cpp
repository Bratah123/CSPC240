/*
  Author: Brandon
  C++ driver for the assembly code
*/
#include <iostream>

extern "C" long int computetriangle();

int main(int argc, char* argv[]) {
  double result = computetriangle();
  printf("The driver received this number %lf and will simply keep it\n", result);
  return 0;
}
