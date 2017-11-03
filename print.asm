VIDEO_MEMORY equ 0xb8000
VIDEO_MEMORY_SIZE equ 4800

print:
	pusha

print_loop:
	lodsb
	or al,al
	jz done_ebx_save
	or ah,0x0F
	mov word [ebx], ax
	add ebx,2
	jmp print_loop

done_ebx_save:
	mov [temp], ebx
	popa
	mov ebx, [temp]
	ret 

print_fromstart:
	pusha
	mov ebx, VIDEO_MEMORY

print_fromstart_loop:
	lodsb
	or al,al
	jz done
	or ah, 0x0F
	mov word [ebx], ax
	add ebx,2
	jmp print_fromstart_loop

clear_screen:
	pusha
	mov ebx, VIDEO_MEMORY

clr_loop:
	mov word [ebx], 0x0000
	add ebx, 2
	cmp ebx, VIDEO_MEMORY + VIDEO_MEMORY_SIZE
	jz done
	jmp clr_loop

done:
	popa
	ret

temp: dd 0