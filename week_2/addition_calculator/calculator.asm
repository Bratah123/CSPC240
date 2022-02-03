;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author: Brandon
; A Program that takes two numbers and returns the sum

;===== Begin code area ==============================================================================================================


;Assembler directives
extern printf ; uses rdi to print prompt
extern scanf ; uses rsi

global testmodule ; the function we will call in the cpp driver

segment .data

welcome db "Welcome to addition calculator!", 10, 0
prompt1 db "Please enter first integer: ", 0
prompt2 db "Please enter second integer: ", 0
floatinputformat db "%lf", 0
displaysum db "The sum of the two numbers you entered is %5.2lf", 0

segment .text

testmodule:
;Prolog Back up the GPRs, Boilerplate
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

; Welcome the user
mov rax, 0 ; doesn't use anything from xmm registers
mov rdi, welcome
call printf
; End of welcome

; Prompt user for first integer
mov rax, 0 ; doesn't use anything from xmm registers
mov rdi, prompt1
call printf
; End of prompt1

;============= Input first float number ============================================================

; push qword 0 ; make space on the stack for scanf block, rsp will point to this (For some reason this causes segmentation fault)
mov rax, 1
mov rdi, floatinputformat
mov rsi, rsp ;  make rsi point to the top of the stack
call scanf ; store the input in rsi
movsd xmm10, [rsp] ; put this input at the top of the stack into xmm10 register

;================================== End of input first float number =====================================

; Prompt user for second integer
mov rax, 0 ; to not use any data from xmm registers
mov rdi, prompt2
call printf

;============= Input second float number ============================================================

; push qword 0 ; make space on the stack for scanf block, rsp will point to this (For some reason this causes segmentation fault)
mov rax, 1
mov rdi, floatinputformat
mov rsi, rsp ; make rsi point to the top of the stack
call scanf ; store the input in rsi
movsd xmm9, [rsp] ; put this input at the top of the stack into xmm8 register

;================================== End of input second float number =====================================

;================================== Start of Display Sum =====================================
mov rax, 1 ; indicate printf of how many we will use
addsd xmm10, xmm9 ; add them together
movsd xmm0, xmm10 ; mov them to xmm0 for printf
mov rdi, displaysum
call printf
;================================== End of Display Sum =====================================

;Epilogue: restore data to the values held before this function was called.
; Boiler Plate
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp               ;Restore the base pointer of the stack frame of the caller.
mov rax, 1 ; return 1 when program is executed succesfully
ret
