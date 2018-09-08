
        global _start
        extern  printf
        extern  asm_prime

section .text


_start:

        ; RCX will hold our counter and r9 will hold the then largest factor
        mov     rcx, 1
        xor     r9, r9

iter_factors:

        mov     rbx, rcx
        imul    rbx, rbx
        
        ; We check if our current factor is fewer than the square root
        mov     rax, qword max_
        cmp     rbx, rax
        jg      _complete_res   ; rcx * rcx > MAX

        xor     rdx, rdx

        mov     rbx, rcx

        xor     rdx, rdx
        idiv    rbx

        cmp     rdx, 0
        jne     next_factor

        mov     edi, ecx

        push    rcx
        call    asm_prime
        pop     rcx

        cmp     rax, 1
        jne     next_factor

        mov     r9, rcx

next_factor:

        add     rcx, 2
        jmp     iter_factors


_complete_res:

        mov     rdi, r9
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

max_    equ     600851475143

format:
        db      "%ld", 10, 0
        
; vim: ft=nasm
