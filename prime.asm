
        global asm_prime

        section	.text
	
; We pass in one parameter of size 64 bits
; eax is our return value. 
; edi is our input value
; ebx is our counter
; ecx stores the result of the counter squared
; edx is where the remainder is stored

asm_prime:

        xor     eax, eax        ; set return value to zero by default
        cmp     edi, 2          ; Check if less than 2
        jl      end_prime
        je      is_prime

        mov     ebx, edi
        and     ebx, 01H
        jz      end_prime
        add     ebx, 2

trial_divis:

        mov     ecx, ebx
        imul    ecx, ecx        ; Check if our counter is less than sqrt n
        cmp     ecx, edi
        jg      is_prime

        push    rax
        xor     rdx, rdx        ; idiv takes eax by the arg and dx is rem
        mov     eax, edi
        idiv    ebx
        test    edx, edx        ; Check if 0 remainder
        pop     rax

        jz      end_prime
        add     ebx, 2
        jmp     trial_divis


is_prime:
        inc eax

end_prime:
        ret

section	.data

; vim: ft=nasm :

