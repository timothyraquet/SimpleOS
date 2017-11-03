all: boot.bin

boot.bin: boot.asm
	nasm boot.asm -o boot.bin