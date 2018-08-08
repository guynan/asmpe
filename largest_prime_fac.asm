
        global _start
        extern  printf
        extern  asm_prime

section .text


_start:

;        xor     rcx, rcx        ; Counter
        mov     rcx, 1
        xor     rbx, rbx
        xor     r9, r9
;        inc     rcx

iter_factors:

        mov     rbx, rcx
        imul    qword rbx, rbx
        
        mov     rax, MAX_
        cmp     rbx, rax
        jg      print_result            ; rcx * rcx > MAX

        xor     rdx, rdx

        mov     rbx, rcx
        push    rcx
        idiv    qword rbx
        pop     rcx

        cmp     rdx, 0
        jne     next_factor

        mov     edi, ecx
        xor     rax, rax

        push    rcx
        call    asm_prime
        pop     rcx

        test    eax, eax
        cmovnz  r9, rcx

next_factor:

        inc     rcx
        jmp     iter_factors


print_result:

        mov     rdi, format
        mov     rsi, r9
        xor     rax, rax

        call    printf      

end_exec:

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
