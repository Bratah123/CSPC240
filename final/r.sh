#!/bin/bash

#Author: Brandon P. Nguyen
#Section: CPSC 240-09
#Email: brandonnguyen3301@csu.fullerton.edu
#Program: Bash Script to compile for Final's Program in non-gdb mode

echo "Bash: The script file for Resistance has begun"

if g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o driver.o driver.cpp; then
	echo "Successfully compiled driver.cpp"
else
	echo "Failed to compile driver.cpp"
	exit
fi

if nasm -f elf64 -o resistance.o resistance.asm; then
	echo "Successfully compiled resistance.asm"
else
	echo "Failed to compile resistance.asm"
	exit
fi

if g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 resistance.o driver.o; then
	echo "Successfully linked cpp and asm files together."
else
	echo "Failed to link cpp and asm files together."
	exit
fi

echo "Successfully compiled program, running program...\n"
./code.out
