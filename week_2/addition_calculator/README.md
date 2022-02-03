My second assembly program to test my current knowledge.

This program will take two inputs from the user and return the sum of those two numbers

Some things to note about this program: 
- using `push qword 0` caused segmentation fault even when popping accordingly to keep a balanced stack
- When using xmm8 register, it causes a garbage number so instead i used xmm9-16 for inputs and xmm0-8 for printf. (Could this be a stack issue?)
