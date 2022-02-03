;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author: Brandon
; A Program that prints hello world

;===== Begin code area ==============================================================================================================


;Assembler directives
extern printf ; uses rdi to print prompt
extern scanf ; uses rsi

global testmodule ; the function we will call in the cpp driver

segment .data

hello_world db "Hello World", 10
;                             ^ newline character


segment .bss  ; Reserved for uninitialized arrays
   ;Empty

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

; Start of Hello World Prompt
mov rax, 0 ; system read also makes sure printf doesn't use anything from r
mov rdi, hello_world
call printf

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
ret

;========================================================================================
