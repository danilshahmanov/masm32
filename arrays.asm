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
    ARRAY_SIZE             equ 10
	prompt_element         db "Введите элемент массива: ", 0
    format                 db "%d", 0
.data?
	array                  dw ARRAY_SIZE dup(?)
.code
main proc  
    ;offset is operation for getting address
    mov         esi, offset array
    mov         ebx, 0

input_elements:
    invoke crt_printf, addr prompt_element
    invoke crt_scanf, offset format, esi
    add         esi, 4
    inc         ebx
    cmp         ebx , 10
    jl          input_elements
    mov         esi, offset array
    mov         ebx, 1

check_order:
    mov         eax, [esi]
    mov         edx, [esi+4]
    cmp         edx, eax
    jg          on_not_decreasing
    add         esi, 4
    inc         ebx
    cmp         ebx , 10
    jl          check_order

on_decreasing:
    invoke crt_printf, offset format,  0 
    jmp         end_program

on_not_decreasing:
    invoke crt_printf, offset format,  [esi+4] 

end_program:
    invoke      ExitProcess, 0

main endp

end
