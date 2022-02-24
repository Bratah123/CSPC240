#!/bin/bash

#Program: Compute Triangle Compilation Script
#Author: Brandon Nguyen

echo "Bash: The script file for triangles has begun"

if g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o scan.o triangles.cpp; then
	echo "Successfully compiled triangles.cpp"
else
	echo "Failed to compile triangles.cpp"
	exit
fi

if nasm -f elf64 -o valid.o triangles.asm; then
	echo "Successfully compiled triangles.asm"
else
	echo "Failed to compile triangles.asm"
	exit
fi

if g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 scan.o valid.o; then
	echo "Successfully linked cpp and asm files together."
else
	echo "Failed to link cpp and asm files together."
	exit
fi

echo "Successfully compiled program, running program..."
./code.out