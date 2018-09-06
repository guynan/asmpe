
; Find the summation of primes below 2 Million

        global _start
        extern printf
        extern asm_prime

section .text

_start:

        ; rbx represents our running summation, rcx is our counter
        mov     rbx, 2
        mov     rcx, 3

_trial_iter:

        cmp     rcx, 2000000
        jg      _complete_result

        mov     rdi, rcx

        push    rbx
        push    rcx

        call    asm_prime

        pop     rcx
        pop     rbx

        cmp     eax, 1
        jne     _inc_count

        add     rbx, rcx

_inc_count:

        add     rcx, 2
        jmp     _trial_iter


_complete_result:

        mov     rdi, rbx
        call    print_result

        call    _end_execution

print_result:

        mov     rsi, rdi
        push    rdi
        mov     rdi, format
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

