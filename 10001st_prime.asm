; Simply find the 10001st prime.

        global _start
        extern  printf
        extern  asm_prime

section .text


_start:

        ; rax is our counter `i`
        ; rbx holds the value of how many primes we are yet to find

        mov     eax, 3
        mov     ebx, 10000

_next_trial:

        mov     edi, eax

        push    rax
        push    rbx

        call    asm_prime

        pop     rbx

        ; Here we subtract the result of `asm_prime` from our remaining prime
        ; counter. In the event that it is a prime, the value of eax will be 1
        ; and will indicate that we have one fewer prime to search for. In the
        ; converse event where it is not prime, then subtraction of zero from
        ; our prime counter will yield the current number of primes yet to find

        sub     ebx, eax
        pop     rax

        ; No more primes to find... Print the result.
        cmp     ebx, 0
        je      _complete_result

        add     eax, 2
        jmp     _next_trial


_complete_result:

        mov     edi, eax
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
