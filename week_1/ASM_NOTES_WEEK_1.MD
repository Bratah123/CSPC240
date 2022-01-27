# Week 1 Assembly
Summary of week 1 assembly lecture notes.

## Keywords:
- quadword: 8 bytes or 64 bits
  - ends in 8 or 0
- doubleword: 4 bytes or 32 bits
- word: 2 bytes or 16 bits

- db: define bytes
- dq: define quadwords
  - C++: long[]
- dd: define doubles
  - C++: int[]
- dw: define words
  - C++: short[]

- AVX: ??? (I couldn't catch this one during the lecture)
- SSE: ??? (I couldn't catch this one during the lecture)
- AVE: Advanced Vector Extension
- FPU: Floating Point Unit
- GPR: General Purpose Registers
- SIMD: Single Instruction Multiple Data

## Registers: 17 Total (r)
- rax
  - Most general purpose.
  - Passes integer (1 at a time) from called function to the calling function
  - temporary storage, remove and discard stuff from the stack
- rbx
- rcx
- rdx
- rdi
- rsi
- rbp (Important)
  - Below rsp (On top of rbp on a memory diagram)
  - Address of activation record (backend)
- rsp (Important)
  - Top of the stack
  - Address of the front-end of activation record
- r8
- r9
- r10
- r11
- r12
- r13
- r14
- r15

## Examples:
- 16 hex digits = 64 bits.
  - Example Address: 000FFFF87AB44870
  - 1 hex digit: 4 bits = 4870 (Last 4 digits of the 64 bit address above)
- Addresses on a Stack Drawing:
  - ![addresses_on_stack]https://media.discordapp.net/attachments/746519006961336370/936350401828118548/4afdbfc332ba61fcfb122fd1845897e6.png?width=754&height=609)

## Assembly Source Code Structure
  ```asm
  ; ----------------------------
  ; Your Name
  ; Name of Program
  ; Purpose
  ; ----------------------------

  ; Directives:
  ; ----------------------------
  ; extern (external functions)
  ;   extern printf
  ;   etc...
  ; global
  ;   global right_triangle
  ;   function from this file will be callable from another file
  ; equ (constants)
  ;   pi equ 3.141598
  ; ----------------------------

  ; Store pre-determined arrays
  ; ----------------------------
  ; segment .data
  ; greeting db "Happy Birthday", 0
  ;                      append ^ ^ NULL
  ; scores dq 37, 42, 100, 6
  ; ----------------------------
  ; db = define bytes
  ; C++ Equivalent:
  ;   char greeting[15] = "Happy Birthday";
  ;   long scores[4] = {37, 42, 100, 6};
  ```

## Outputting a string in Assembly
  ```asm
  segment .data
  care db "We take care of your triangles", 0

  segment .text
  ; 16 pushes that back up register data (copy paste from other files)

  ; Block to output care message
  mov rax, 0
  mov rdi, care ; rdi is the register that gets outputted by printf
  call printf
  ; Block to prompt for inputs
  mov rax, 0
  mov rdi, prompt
  call printf
  ; Block to input names (fgets)
  ```

## Gallery
- Stack Drawing (rbp in this example is supposed to be rsp):
![Stack](https://media.discordapp.net/attachments/746519006961336370/936349335719931954/806db5ed28c1d52fb85afa1611bf4944.png)
- pushing rax:
![rax](https://cdn.discordapp.com/attachments/746519006961336370/936352096033312808/52780ec938d1317abdb351f8910c3859.png)
- rbp & rsp examples:
![rbp_rsp](https://media.discordapp.net/attachments/746519006961336370/936353582477901854/21ad3625219ab002c27c71c59942d645.png?width=814&height=609)
