
        global _start
        extern printf

section .text

_start:

        ; eax 
        mov     rdi, 100
        call    sum_consec_squares
        mov     rbx, rax

        push    rbx
        call    sum_consec_int
        pop     rbx

        imul    rax, rax
        sub     rax, rbx
        mov     rdi, rax

        call    print_result
        call    _end_execution

; We use a nice little formula which can be easily derived;
; -> (n * (n + 1)(2n + 1))/6
sum_consec_squares:

        mov     rcx, 6

        mov     rax, rdi
        inc     rax

        ; ebx = (2n + 1)
        mov     rbx, rdi
        imul    rbx, 2
        inc     rbx

        imul    rax, rbx
        imul    rax, rdi

        ; rax is now the numerator
        xor     rdx, rdx
        idiv    rcx

        ret

; Sum consecutive integers is n(n + 1) / 2
sum_consec_int:

        mov     rbx, 2
        mov     rax, rdi
        inc     rax
        imul    rax, rdi

        xor     rdx, rdx
        idiv    rbx

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

