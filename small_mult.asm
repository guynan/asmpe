
        global  _start
        extern  printf

section .text

_start:

        mov     rax, 2

iter_next:

        mov     rdi, rax
        push    rax
        call    test_divis
        cmp     rax, 1

        pop     rax
        je      print_result

        add     rax, 2
        jmp     iter_next


test_divis:

        xor     eax, eax

        ; It must be an even number
        test    edi, 01h
        jnz     complete_divis
        mov     ebx, 3          ; the current divisor we test

iter_divis:

        cmp     ebx, 20
        jle     next_trial      

        inc     eax
        jmp     complete_divis

next_trial:

        xor     edx, edx

        push    rax
        mov     eax, edi
        idiv    ebx
        pop     rax

        cmp     edx, 0
        jne     complete_divis

        add     ebx, 1
        jmp     iter_divis

complete_divis:

        ret


print_result:

        mov     rdi, format
        mov     rsi, rax
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

