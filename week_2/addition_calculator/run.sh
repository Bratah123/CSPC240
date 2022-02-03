#!/bin/bash

#Program: Addition Calculator Compilation Script
#Author: Brandon Nguyen

echo "Bash: The script file for Hello World has begun"

g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o scan.o addition_calculator.cpp && nasm -f elf64 -o valid.o calculator.asm && g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 scan.o valid.o
