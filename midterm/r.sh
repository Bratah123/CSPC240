#!/bin/bash

#Author: Brandon P. Nguyen
#Section: CPSC 240-09
#Email: brandonnguyen3301@csu.fullerton.edu
#Program: Bash Script to compile for Midterm Program

echo "Bash: The script file for Power Computation has begun"

if g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o ampere.o ampere.cpp; then
	echo "Successfully compiled ampere.cpp"
else
	echo "Failed to compile ampere.cpp"
	exit
fi

if nasm -f elf64 -o faraday.o faraday.asm; then
	echo "Successfully compiled faraday.asm"
else
	echo "Failed to compile faraday.asm"
	exit
fi

if g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 faraday.o ampere.o; then
	echo "Successfully linked cpp and asm files together."
else
	echo "Failed to link cpp and asm files together."
	exit
fi

echo "Successfully compiled program, running program...\n"
./code.out
