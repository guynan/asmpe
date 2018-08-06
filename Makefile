


all: link


prime.o: prime.asm
	nasm -f elf64 -o prime.o prime.asm

main.o: main.asm
	nasm -f elf64 -o main.o main.asm

link: main.o prime.o
	gcc main.o prime.o -nostartfiles

mult35: mult35.asm
	nasm -f elf64 -o mult35.o mult35.asm
	gcc mult35.o -nostartfiles

small_mult: small_mult.asm
	nasm -f elf64 -o small_mult.o small_mult.asm
	gcc small_mult.o -nostartfiles

clean:
	$(RM) *.o
