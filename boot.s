; Declare constants for the Multiboot header.
ALIGNED    equ  1<<0
MEMINFO    equ  1<<1
FLAGS      equ  ALIGNED | MEMINFO
MAGIC      equ  0x1BADB002
CHECKSUM   equ -(MAGIC + FLAGS)

; Multiboot header that GRUB looks for
section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

; Set up a stack (C++ needs this for functions)
section .bss
align 16
stack_bottom:
resb 16384 ; 16 KiB
stack_top:

section .text
global _start:function (_start.end - _start)
_start:
    mov esp, stack_top    ; Point the CPU to our stack
    extern kernel_main
    call kernel_main      ; Jump to your C++ code

    cli                   ; If C++ returns, stop the CPU
.hang:  hlt
    jmp .hang
.end:
