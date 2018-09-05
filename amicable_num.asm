
; Find the sum of all of the amicable numbers below 10,000

        global _start
        extern printf

section .text

_start:

        ; To evaluate this, we use rcx as our counter, rbx as the summation

        xor     rcx, rcx
        mov     ecx, 1
        xor     rbx, rbx

iter_range:

        cmp     ecx, 10000
        jg      _complete_result

        mov     edi, ecx

        push    rcx
        push    rbx

        call    amicable

        pop     rbx
        pop     rcx

        cmp     eax, 1
        jne     _inc_counter

        add     ebx, ecx

_inc_counter:

        inc     ecx
        jmp     iter_range

_complete_result:

        mov     edi, ebx
        call    print_result
        call    _end_execution


; A number is amicable if the sum of the factors of the number is equal to the
; sum of the factors of that sum. We accept a number in rdi as our input value,
; ecx is the result of our input number n sum of factors,
amicable:

        call    sum_factors
        mov     ecx, eax

        xor     rax, rax
        cmp     edi, ecx
        je      _not_amicable

        push    rdi
        mov     edi, ecx
        push    rcx

        call    sum_factors

        pop     rcx
        pop     rdi

        mov     ebx, eax
        xor     rax, rax

        cmp     ebx, edi
        jne     _not_amicable

        inc     eax

_not_amicable:

        ret

; take a number in rdi, return value in rax, which is our summation. rcx is our
; counter
sum_factors:

        xor     rax, rax
        mov     ecx, 1

_factor_iter:

        push    rcx
        imul    ecx, 2
        cmp     ecx, edi
        pop     rcx
        jg      _end_sum

        ; idiv uses rdx as the remainder, eax as the divisor 
        xor     rdx, rdx
        mov     ebx, ecx

        ; Preserve our current sum
        push    rax
        push    rcx

        mov     eax, edi

        idiv    ebx

        pop     rcx
        pop     rax

        test    edx, edx
        jnz     _next_factor

        add     eax, ecx

_next_factor:

        inc     ecx
        jmp     _factor_iter

_end_sum:

        ret

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

