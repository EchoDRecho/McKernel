[BITS 16]
[ORG 0x7C00]



start:
	mov ax, 0xB800
	mov es, ax
	mov ax, 0x0F20
	mov cx, 2000
	mov di, 0
	


cls_main:
	mov [es:di], ax 
	add di, 2
	loop cls_main


write_to_scr:            

	mov di, 0
	mov ah, 0x9F
	mov si, my_data 

main_loop:    
	lodsb
	cmp al, 0
	je done

	mov [es:di], al
	inc di
	mov [es:di], ah
	inc di


	jmp main_loop

done:
	jmp $




my_data: db "hello, i'm the boot file, i was ran by the BIOS, and i print to screen without using interrups :D", 0

times 510-($-$$) db 0
dw 0xAA55
