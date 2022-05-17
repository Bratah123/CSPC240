; Author: Brandon P. Nguyen
; CWID: 887028942
; Section: CPSC 240-09
; Email: brandonnguyen3301@csu.fullerton.edu
; Purpose: The code related to the final for CPSC 240-09

extern printf   ; includes printf
extern scanf    ; includes scanf

global resistance

; constants here

segment .data

intro db "We will manage all your circuits", 10, 0

clock_time db "The start time on the clock is now %d tics.", 10, 0

one_float db "%lf", 0
first_subcircuit db "Please enter the resistance of the first subcircuit: ", 0
second_subcircuit db "Please enter the resistance of the second subcircuit: ", 0

computed_resistance db "The computed total resistance is %lf ohms.", 10, 0

conclusion db "The Electric Resistance will send the Total Resistance to the caller.", 10, 0

end_time db "The end time on the clock is now %d tics.", 10, 0
total_time db "The total time for this computation was %d tics.", 10, 10, 0

segment .bss
; unintialized arrays here

segment .text

resistance:
push rbp ; Push memory address of base of previous stack frame onto stack top

mov rbp, rsp ; Copy value of stack pointer into base pointer, rbp = rsp = both point to stack top
; Rbp now holds the address of the new stack frame, i.e "top" of stack
push rdi ; Backup rdi
push rsi ; Backup rsi
push rdx ; Backup rdx
push rcx ; Backup rcx
push r8 ; Backup r8
push r9 ; Backup r9
push r10 ; Backup r10
push r11 ; Backup r11
push r12 ; Backup r12
push r13 ; Backup r13
push r14 ; Backup r14
push r15 ; Backup r15
push rbx ; Backup rbx
pushf ; Backup rflags

; START OF PROGRAM

; Read start clock time in tics
cpuid
rdtsc
shl rax, 32
add rdx, rax
mov r14, rdx ; we'll move the tics into r14 for later calculations

; Print the starting clock time in tics
mov rax, 0
mov rdi, clock_time
mov rsi, r14   ; move our start time in tics to rsi for printf
call printf

; Print introduction dialogue
mov rax, 0
mov rdi, intro
call printf

; dialogue to ask for first input
mov rax, 0
mov rdi, first_subcircuit
call printf

; scanf for first input
push qword 0 ; we need this to stay on the boundary for scanf

push qword 0 ; make space for the input
mov rax, 1
mov rsi, rsp
mov rdi, one_float
call scanf
movsd xmm10, [rsp] ; first resistance in xmm10
pop rax

pop rax ; pop the bounadry push

; dialogue to ask for second input
mov rax, 0
mov rdi, second_subcircuit
call printf

; scanf for second input
push qword 0 ; we need this to stay on the boundary for scanf

push qword 0 ; make space for the input
mov rax, 1
mov rsi, rsp
mov rdi, one_float
call scanf
movsd xmm11, [rsp] ; second resistance in xmm11
pop rax

pop rax ; pop the boundary push

; Computation of the Total Resistance
; Formula: 1/xmm10 + 1/xmm11
mov rax, 1
cvtsi2sd xmm14, rax ; convert int 1 to float 1.0 and mov into xmm14
mov rax, 1
cvtsi2sd xmm9, rax ; convert int 1 to float 1.0 and mov into xmm9
divsd xmm14, xmm10 ; 1/xmm10
divsd xmm9, xmm11  ; 1/xmm11
addsd xmm14, xmm9 ; (1/xmm10) + (1/xmm11) ; xmm14 = R

mov rax, 1
cvtsi2sd xmm6, rax
divsd xmm6, xmm14
movsd xmm13, xmm6 ; moving total resistance into xmm13

; Print out the total Resistance
mov rax, 1 ; to indicate the usage of xmm registers
mov rdi, computed_resistance
movsd xmm0, xmm13
call printf

; Read end clock time in tics
cpuid
rdtsc
shl rax, 32
add rdx, rax
mov r13, rdx ; move the end tics in r13

; Print out the end time on the clock
; Print the starting clock time in tics
mov rax, 0
mov rdi, end_time
mov rsi, r13   ; move our end time in tics to rsi for printf
call printf

; Print out the total time of computation
mov rax, 0
sub r13, r14 ; end - start to find total tics
mov rdi, total_time
mov rsi, r13
call printf


; END OF PROGRAM
movsd xmm0, xmm13 ; return this number to the driver
mov rax, 0 ; return 0 to OS

popf ; Restore rflags
pop rbx ; Restore rbx
pop r15 ; Restore r15
pop r14 ; Restore r14
pop r13 ; Restore r13
pop r12 ; Restore r12
pop r11 ; Restore r11
pop r10 ; Restore r10
pop r9 ; Restore r9
pop r8 ; Restore r8
pop rcx ; Restore rcx
pop rdx ; Restore rdx
pop rsi ; Restore rsi
pop rdi ; Restore rdi

pop rbp ; Restore rbp

ret ;  return
