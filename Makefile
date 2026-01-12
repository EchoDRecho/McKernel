# Variables for compiler and flags
CC = g++
AS = nasm
AD = nasm
FLAGS = -m32 -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -fno-stack-protector

all: run

kernel.o: kernel.cpp
	$(CC) -c kernel.cpp -o kernel.o $(FLAGS)

boot.o: boot.s
	$(AS) -felf32 boot.s -o boot.o

io.o: io.s
	$(AD) -felf32 io.s -o io.o

McKernel.bin: linker.ld boot.o kernel.o io.o
	$(CC) -m32 -T linker.ld -o McKernel.bin -ffreestanding -O2 -nostdlib boot.o kernel.o io.o -lgcc 

run: McKernel.bin
	qemu-system-i386 -kernel McKernel.bin

clean:
	rm -f *.o McKernal.bin
