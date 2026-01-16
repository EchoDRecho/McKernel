[BITS 16]        ; Tell NASM this is 16-bit code
[ORG 0x7C00]     ; Tell the linker we are loaded at 0x7C00

_start:
    mov ah, 0x0E ; BIOS teletype output function
    mov al, 'B'  ; The character to print
    int 0x10     ; Call BIOS video interrupt

    mov al, 'O'
    int 0x10
    
    mov al, 'O'
    int 0x10

    mov al, 'T'
    int 0x10

    jmp $        ; Loop forever (hang)

; Padding and Signature
times 510-($-$$) db 0 ; Fill the rest of the 510 bytes with zeros
dw 0xAA55             ; The magic boot signature (2 bytes)
