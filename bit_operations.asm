.586
.model flat, stdcall
option casemap:none

includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
include \masm32\include\msvcrt.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\windows.inc
include \masm32\include\masm32.inc

.const
    prompt_number         db "Введите число: ", 0
    format                db "%d", 0
.data?
    number_               dd ?
.code
main:
    call    get_input
    call    replace_left_bits
    call    mul_by_eight
    not     eax
    mov     number_, eax
    call    print_result
    invoke  ExitProcess, 0

mul_by_eight proc
    mov     ecx, eax
    shr     ecx, 31
    or      ecx, ecx
    jnz     on_negative

on_positive:
    shl     eax, 3
    ret     

on_negative:
    not     eax
    or      eax, 1b
    shl     eax, 3
    not     eax
    add     eax, 1
    ret     
mul_by_eight endp

replace_left_bits proc
    mov     eax, number_
    mov     ecx, 111b            ;mask for getting 3 right bits
    and     ecx, eax             ;store 3 right bits in ecx
    shl     ecx, 29              ;move 3 right bits to the left edge
    and     eax, 01FFFFFFFh      ;turn 3 left bits to 0
    or      eax, ecx             ;write 3 right bits to place of 3 left bits
replace_left_bits endp

get_input proc
    invoke  crt_printf, addr prompt_number
    invoke  crt_scanf, addr format, addr number_
    ret    
get_input endp

print_result proc
    invoke  crt_printf, offset format, number_
    ret     
print_result endp

end main


        