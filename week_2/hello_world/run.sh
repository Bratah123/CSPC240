#!/bin/bash

#Program: Hello World
#Author: Brandon Nguyen

#Delete some un-needed files
rm *.o
rm *.out

echo "Bash: The script file for Hello World has begun"

echo "Bash: Compile hello_world.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o scan.o hello_world.cpp

echo "Bash: Assemble test-validation.asm"
nasm -f elf64 -o valid.o test-validation.asm

echo "Bash: Link the object files"
g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 scan.o valid.o

echo "Bash: Run the program Hello World by doing ./code.out"
# ./code.out

#Summary
#The module arithmetic.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.
