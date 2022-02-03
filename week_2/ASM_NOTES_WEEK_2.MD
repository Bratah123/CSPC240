# Week 2 Summary
- Week 2 part 1 is about floating point I/O

## Example
  ```asm
  ; How to input 1 float
  ; %f = float (32 bits)
  ; %lf = double (64 bits)
  ; %d = int (32 bits)
  ; %ld = long (64 bits)
  ; %s = char[] (string)
  ; ... 10 or more specifiers are available

  ; -----------------------
  segment .data
  floatform db "%lf", 0
  ; -----------------------

  ; input float number into xmm13
  mov rax, 1
  mov rdi, floatform
  push qword 37 ; doesn't matter what number, its just to put a qword on top of stack
  ; 'push qword' makes rsp -> 37
  mov rsi, rsp ; rsi currently points to 37
  call scanf ; uses rsi
  movsd xmm13, [rsp] ; movsd = Move Scalar Double-Precision Floating-Point Value
  pop rax ; to pop our 'push qword' command
  ```
  - Example of inputting 2 sides & 1 angle
  ```asm
  ; Input 2 sides & 1 angle
  segment .data
  form3float db "%lf %lf %lf", 0

  segment .text
  ; Block that inputs 2 sides of triangle & the angle included
  ; side 1 = xmm13
  ; side 2 = xmm14
  ; angle = xmm15
  mov rax, 3 ; signal we have 3 inputs
  mov rdi, form3float ; scanf uses this to determine prompt
  push qword -1 ; push these numbers to stack to make space
  push qword 0
  push qword 1 ; rsp points to this
  mov rsi, rsp ; scanf uses rsi so we moved rsp into rsi
  call scanf ; it's going to wait for 3 inputs
  movsd xmm13, [rsp] ; side 1
  pop rax ; moves the stack down rsp will be our second input now
  movsd xmm14, [rsp] ; side 2
  pop rax
  movsd xmm15, [rsp] ; angle
  pop rax ; clean up the stack
  ; Block end
  ```
  ```asm
  ; Put 0.0 into xmm7
  mov rax, 0
  push rax
  movsd xmm7 [rsp]
  pop rax

  ucomisd xmm12, xmm7 ; Unordered Compare Scalar Double-Precision Floating-Point Values and Set EFLAGS
  ; ucomisd is an instruction that compares two xmm registers
  ; ucomisd xmm7, xmm12
  ; Checking to see if: xmm7 < xmm12
                        xmm7 == xmm12
                        xmm7 > xmm12
                        xmm7 >= xmm12
                        xmm7 != xmm12
  ; stores the answer in an rflag
  ; jb: <
  ; jbe <=
  ; ja >
  ; jae >=
  ; je ==
  ; jne !=

  jbe exit ; jump if condition is met: Jump short if below or equal (CF=1 or ZF=1)
  ; compute area of triangle

  ; show final message
  exit:
  ; final message here
  ; return x to driver
  ```
