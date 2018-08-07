
        global _start
        extern  printf
        extern  asm_prime

section .text


_start:

        xor     rcx, rcx        ; Counter
        xor     rbx, rbx
        inc     rcx

iter_factors:

        mov     rbx, rcx
        imul    rbx, rbx
        
        mov     rax, MAX_
        cmp     rbx, rax
        jge     print_result

        xor     rdx, rdx
        idiv    rcx

        test    rdx, rdx
        jnz     next_factor

        xor     rax, rax
        mov     rdi, rcx

        push    rcx
        call    asm_prime
        pop     rcx

        cmp     rax, 0
        jne     next_factor

        mov     r9, rcx

next_factor:

        add     rcx, 2
        jmp     iter_factors


print_result:

        mov     rdi, format
        mov     rsi, r9
        xor     rax, rax

        call    printf      

	mov	rax, 60
	mov	rdi, 0

	syscall

        ret


section .data

MAX_:
        dq       600851475143

format:
        db      "%ld", 10, 0
        


; vim: ft=nasm
