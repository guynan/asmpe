; Find all the multiples of 3 or 5 below 1000

        global _start

        extern printf


section .text


_start:

        mov     r8, 3
        mov     r9, 5
        xor     rbx, rbx        ; sum
        mov     rax, 1          ; counter

iter_mult:

        cmp     eax, 1000       ; Limit 1000
        jge     print_result

        xor     rdx, rdx
        push    rax
        idiv    r8
        pop     rax
        cmp     rdx, 0
        je      short_eval

        xor     rdx, rdx
        push    rax
        idiv    r9
        pop     rax
        cmp     rdx, 0
        jne     no_multiple

short_eval:

        add     rbx, rax        ; sum += counter

no_multiple:

        inc     eax
        jmp     iter_mult

print_result:

        mov     rdi, format
        mov     esi, ebx
        xor     rax, rax

        call    printf      

	mov	rax, 60
	mov	rdi, 0

	syscall

        ret

section .data

format:
        db  "%d", 10, 0

; vim: ft=nasm :

