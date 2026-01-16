[BITS 16]
[ORG 0x7C00]



start:
	mov ax, 0xB800
	mov es, ax
	mov si, dummy_data_to_clear_line
	mov di, 0
	mov ah, 0xAF
	


cls_main:
	lodsb
	cmp al, 0
	je write_to_scr
	mov [es:di], al
	inc di
	mov [es:di], ah
	inc di
	jmp cls_main
	


write_to_scr:

	mov ax, 0xB800
	mov es, ax
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




my_data: db "hello", 0
dummy_data_to_clear_line: times 446 db ' '

times 510-($-$$) db 0
dw 0xAA55
