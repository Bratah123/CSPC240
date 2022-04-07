; Author: Brandon P. Nguyen
; CWID: 887028942
; Section: CPSC 240-09
; Email: brandonnguyen3301@csu.fullerton.edu
; Purpose: The code related to the midterm for CPSC 240-09

extern printf   ; includes printf
extern scanf    ; includes scanf
extern atof
extern fgets
extern strlen
extern stdin
extern verify_float
extern show_electricity
extern show_power

global get_electricity

; constants
max_len equ 32

segment .data

intro db "Welcome to Power Computation by Brandon Nguyen", 10,
      db "We handle all your electricity", 10, 0

invalid db "Invalid. Enter again", 10, 0
thanks_msg db "Thank you", 10, 0
wait_msg db 10, "Please wait: work is being computed", 10, 0
sent_msg db "The work number will be sent to ampere.", 10, 0

inp_prompt db "Please enter the two quantities volts and resistance in that order", 10, 0
inp_format db "%lf"

string_format db "%s", 0

int_format db "%ld", 10, 0

segment .bss
; unintialized arrays
user_volts resb max_len
user_ohms resb max_len

segment .text

get_electricity:
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


; Introduction block
mov rax, 0
mov rdi, string_format
mov rsi, intro
call printf
; Introduction block end

; Ask for Input block
mov rax, 0
mov rdi, string_format
mov rsi, inp_prompt
call printf
; Ask for Input block end

; Ask for volts block
mov rax, 0
mov rdi, user_volts
mov rsi, max_len
mov rdx, [stdin]
call fgets
; Ask for volts block end

; remove newline character at the end of user_volts
mov rax, 0
mov rdi, user_volts
call strlen
sub rax, 1
mov byte [user_volts+rax], 0 ; replace the newline with null
; remove newline character at the end of user_volts end

; Convert our string to a float for math purposes
mov rax, 1
mov rdi, user_volts
call atof
movsd xmm10, xmm0 ; we will store the user votages to xmm10
jmp ask_input_ohms
; Note from instructions: no need for float verication for the first input
; End of voltage conversion

; Asking for OHMS --------------------------------------------------------------
invalid_message_ohms:
; invalid message block
mov rax, 0
mov rdi, string_format
mov rsi, invalid
call printf

ask_input_ohms:
; Ask for volts block
mov rax, 0
mov rdi, user_ohms
mov rsi, max_len
mov rdx, [stdin]
call fgets
; Ask for ohms block end

; remove newline character at the end of user_ohms
mov rax, 0
mov rdi, user_ohms
call strlen
sub rax, 1
mov byte [user_ohms+rax], 0 ; replace the newline with null
; remove newline character at the end of user_ohms end

mov rax, 1 ; indicate we use one parameter
mov rdi, user_ohms
call verify_float
mov r11, rax ; r11 stores our result boolean
jz invalid_message_ohms ; if verify_float == 0: jmp invalid_message_ohms

; Convert our string to a float for math purposes
mov rax, 1
mov rdi, user_ohms
call atof
movsd xmm11, xmm0 ; we will store the user ohms to xmm11
; End of ohms conversion

; Thanks block
mov rax, 0
mov rdi, string_format
mov rsi, thanks_msg
call printf

; Show electricity
mov rax, 2        ; indicate two parameters
movsd xmm0, xmm10 ; volts
movsd xmm1, xmm11 ; ohms
call show_electricity

; Work is being computed message
mov rax, 0
mov rdi, string_format
mov rsi, wait_msg
call printf

; Compute Joules ---------------------------------------------------------------
; Find P given V and R P = V^2/R
; xmm10 = V
; xmm11 = R
; xmm10 * xmm10 / xmm11 = P
; xmm13 will store the Work number
movsd xmm13, xmm10 ; xmm13 = V
mulsd xmm13, xmm10 ; xmm13 = V * V
divsd xmm13, xmm11 ; xmm13 = (V * V) / R

; show power
mov rax, 1
movsd xmm0, xmm13
call show_power

mov rax, 0
mov rdi, string_format
mov rsi, sent_msg
call printf


; END of program ---------------------------------------------------------------
movsd xmm0, xmm13 ; return ampere the work number
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
