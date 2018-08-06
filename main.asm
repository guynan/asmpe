
        global  _start
        extern  printf
        extern  asm_prime

section .text

_start:

        xor     rbx, rbx
        xor     rcx, rcx

range_iter:

        cmp     rbx, 1000000
        jge     print_result

        xor     rax, rax
        mov     rdi, rbx

        push    rbx
        push    rcx

        call    asm_prime

        pop     rcx
        pop     rbx

        add     rcx, rax        ; Our result is either a 1 or zero

        inc     rbx
        jmp     range_iter

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


; vim: ft=nasm :

