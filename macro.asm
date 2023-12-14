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
	number_          dd ?

    mul_by_eight macro reg
        shl     reg, 3
    endm

    change_sign macro reg
        not     reg
        add     reg, 1
    endm

    get_3_right_bits macro result, source
        mov     result, 111b
        and     result, source
        shl     result, 29
    endm

    set_zero_3_bits macro reg
        and     reg, 01FFFFFFFh
    endm

    get_sign_bit macro result, source
        mov     result, source
        shr     result, 31
    endm
.code
main:
    call              get_input
    call              replace_left_bits
    call              mul_by_eights
    not               eax
    mov               number_, eax
    call              print_result
    invoke            ExitProcess, 0

mul_by_eights proc
    get_sign_bit ecx, eax
    or                ecx, ecx
    jnz               on_negative

on_positive:
    mul_by_eight      eax
    ret     

on_negative:
    change_sign       eax
    mul_by_eight      eax
    change_sign       eax
    ret     
mul_by_eights endp

replace_left_bits proc
    mov               eax, number_
    get_3_right_bits  ecx, eax
    set_zero_3_bits   eax
    or                eax, ecx
    ret     
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


        