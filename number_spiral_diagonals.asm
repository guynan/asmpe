
        global _start
        extern  printf
        extern  asm_prime

section .text


_start:
        ; This one is done by a pen and paper reduction of the problem. I
        ; found that I could represent the right corner trivially as the
        ; number of what iteration of square it was, squared. The subsequent
        ; results were as follows;
        ;
        ; S0 = n**2;
        ; S1 = n**2 - (n - 1);
        ; S2 = n**2 - 2(n - 1);
        ; S3 = n**2 - 3(n - 1);
        ;
        ; Thus, our formula for the sum of all of these 'rings' in the square
        ; is subsequently: 4*n**2 - 6(n-1). Note however, this solution is for
        ; n in reals > 1

        xor     rbx, rbx
        xor     rdi, rdi
        inc     rbx
        mov     rax, 3
        mov     r9, 1001

_next_spiral:

        cmp     rax, r9
        jg      _complete_result

        mov     edi, eax

        push    rax
        push    rbx

        call    outer_spiral

        pop     rbx

        add     ebx, eax
        pop     rax

        add     eax, 2

        jmp     _next_spiral


outer_spiral:

        mov     eax, edi
        imul    eax, eax
        imul    eax, 4
        mov     ebx, edi
        dec     ebx
        imul    ebx, 6
        sub     eax, ebx
        ret

_complete_result:

        mov     edi, ebx
        call    print_result
        call    _end_execution

print_result:

        mov     ebx, edi
        push    rdi
        mov     rdi, format
        mov     esi, ebx
        xor     rax, rax

        call    printf      
        pop     rdi
        ret

_end_execution:

	mov	rax, 60
	mov	rdi, 0

	syscall

        ret

section .data

format:
        db      "%ld", 10, 0


; vim: ft=nasm
