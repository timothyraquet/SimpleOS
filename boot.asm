[bits 16]
[org 0x7c00]

boot:
	mov ax, 0x2401
	int 0x15       ; activate higher address
	mov ax, 0x3
	int 0x10       ; set vga text mode 3
	cli
	lgdt [gdt_pointer] ; load global descriptor table
	mov eax, cr0
	or eax,0x1
	mov cr0, eax       ; were in protected mode now
	jmp CODE_SEG:boot2

%include 'gdt.asm'

[bits 32]

boot2:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp main


main:
	mov ebx, VIDEO_MEMORY
	mov esi, HELLOWORLD 
	call print
	jmp $
	

%include 'print.asm'

halt:
	cli
	hlt

HELLOWORLD: db "Hello World", 0

times 510 - ($-$$) db 0
dw 0xaa55
