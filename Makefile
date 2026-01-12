# Variables for compiler and flags
CC = g++
AS = nasm
FLAGS = -m32 -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

all: run

kernel.o: kernel.cpp
	$(CC) -c kernel.cpp -o kernel.o $(FLAGS)

boot.o: boot.s
	$(AS) -felf32 boot.s -o boot.o

mykernel.bin: linker.ld boot.o kernel.o
	$(CC) -m32 -T linker.ld -o mykernel.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

run: mykernel.bin
	qemu-system-i386 -kernel mykernel.bin

clean:
	rm -f *.o mykernel.bin
