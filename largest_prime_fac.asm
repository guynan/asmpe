
        global _start
        extern  printf
        extern  asm_prime

section .text

        

_start:


print_result:

        mov     rdi, format
        mov     rsi, rcx
        xor     rax, rax

        call    printf      

	mov	rax, 60
	mov	rdi, 0

	syscall

        ret


section .data

format:
        db  "%ld", 10, 0


; vim: ft=nasm
