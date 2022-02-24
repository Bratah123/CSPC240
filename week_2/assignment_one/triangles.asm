;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author: Brandon
; A Program that takes 3 inputs, 2 lengths of a triangle and the angle between
; The Program then computes the perimeter and area and returns it to the user
;===== Begin code area ==============================================================================================================


; Assembler directives
extern printf ; uses rdi to print prompt
extern scanf  ; uses rsi
extern cos
extern sin

global computetriangle ; the function we will call in the cpp driver

segment .data
pi dq 0x400921FB54442D18

welcome db "Welcome to Amazing Triangles programmed by Brandon Nguyen.", 10, 0

welcome2 db "We take care of all your triangles.", 10, 0

enter_name db "Please enter your name: ", 0

one_string db "%s", 0

good_morning db "Good morning %s, ", 0

input_prompt db "please enter the length of side 1, length of side 2, and size (degrees) of the included angle between them as real float numbers."
             db "Separate the numbers by white space, and be sure to press <enter> after the last inputted number.", 10, 0

inputs db "%lf %lf %lf", 0

entered db "You entered %lf %lf %lf", 10, 0

area_prompt db "The area of your triangle is %lf square units", 10, 0

segment .bss  ; Reserved for uninitialized arrays
   ;Empty

segment .text
computetriangle:

; Prolog Back up the GPRs, Boilerplate
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

; Start of prompt --------------------------------------------------------------
push qword 0
mov rax, 0        ; system read also makes sure printf doesn't use anything from r
mov rdi, welcome
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, welcome2
call printf
pop rax
; End of prompt ---------------------------------------------------------------

; Enter your name prompt -------------------------------------------------------
push qword 0
mov rax, 0
mov rdi, enter_name
call printf
pop rax

push qword 0

push qword 0

sub rsp, 1024       ; move the top of the stack 1024 bytes to make space for string
mov rax, 0          ; protocol system call
mov rdi, one_string ; provide prompt
mov rsi, rsp        ; change rsi to point to the top of the stack
mov rdx, rsp
add rdx, 1024       ; let rdx point to the top of the stack (temp)
call scanf
; End of name prompt -----------------------------------------------------------

; Good morning prompt ----------------------------------------------------------
mov rax, 0
mov rdi, good_morning
mov rsi, rsp
call printf
add rsp, 1024 ; Move the rsp to the top of the stack again
pop rax

pop rax
; End of Good morning prompt ---------------------------------------------------

; Input Instruction Start ------------------------------------------------------

push qword 0
mov rax, 0
mov rdi, input_prompt
call printf
pop rax

; Input Instruction End --------------------------------------------------------

; Inputs Start -----------------------------------------------------------------
push qword 0

mov rax, 3          ; indicate that 3 inputs are going to be inputted
mov rdi, inputs
push qword 0        ; make space for 3 floats
push qword 0
push qword 0
mov rsi, rsp        ; rsp = side A
mov rdx, rsp
add rdx, 8          ; rdx = rsp+8 = side B
mov rcx, rsp
add rcx, 16         ; rcx = rsp+16 = angle (degrees)
call scanf
movsd xmm10, [rsp]   ; length of side 1 triangle
pop rax
movsd xmm11, [rsp]  ; length of side 2 triangle
pop rax
movsd xmm12, [rsp]  ; angle between two sides (degrees)
pop rax

pop rax
; Inputs Start End -------------------------------------------------------------

; Display Inputs ---------------------------------------------------------------
mov rax, 3          ; indicate usage of xmm registers
mov rdi, entered
movsd xmm0, xmm10   ; side 1
movsd xmm1, xmm11   ; side 2
movsd xmm2, xmm12   ; angle (degrees)
call printf
; Display Inputs End -----------------------------------------------------------

; Convert Degree to Radians ----------------------------------------------------
mulsd xmm12, [pi]
mov rax, 180
cvtsi2sd xmm13, rax
divsd xmm12, xmm13 ; xmm12 is now the angle in radians
; Convert Degree to Radians End ------------------------------------------------
; Compute Area of Triangle -----------------------------------------------------
; Formula: (side1 * side2 * sin(angle))/2 in radians
mov rax, 1
cvtsi2sd xmm14, rax
mulsd xmm14, xmm10 ; 1 * side1
mulsd xmm14, xmm11 ; 1 * side1 * side2
movsd xmm0, xmm12
call sin           ; sin(angle) in rads
mulsd xmm14, xmm0  ; 1 * side1 * side2 * sin(angle)
mov rax, 2
cvtsi2sd xmm15, rax
divsd xmm14, xmm15 ; (1 * side1 * side2 * sin(angle)) / 2
; Compute Area of Triangle End -------------------------------------------------

; Print Out Area ---------------------------------------------------------------
mov rax, 1
mov rdi, area_prompt
movsd xmm0, xmm14
call printf
; Print Out Area End -----------------------------------------------------------

; Compute Perimeter of Triangle ------------------------------------------------
; Formula: sqrt(A^2 + B^2 - 2AB*cos(x))
; mov rax, 1
; cvtsi2sd xmm14, rax
; Compute Perimeter of Triangle End --------------------------------------------


; Epilogue: restore data to the values held before this function was called.
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
pop rbp               ; Restore the base pointer of the stack frame of the caller.
ret
; ========================================================================================
