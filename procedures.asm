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

.data
    prompt_string       db "Введите строку: ", 0
    
    input               db 256 dup(0)
    output              db 256 dup(0)

.code
main:
    call input_string
    call process
    call print_output
    invoke ExitProcess, 0

input_string proc
    invoke crt_printf, addr prompt_string
    invoke StdIn, addr input, 256
    ret
input_string endp

process proc
    lea    esi, input
    lea    edi, output
process_loop:
    mov    al, byte ptr [esi]
    test   al, al
    jz     add_null_terminate 
    cmp    al, ' '
    je     on_space_symbol
    
write_symbol_to_output:
    mov    [edi], al
    inc    edi
    inc    esi
    jmp    process_loop

on_space_symbol:
    mov    bl, byte ptr [edi-1]
    cmp    bl, al
    jne    write_symbol_to_output
    inc    esi
    jmp    process_loop

add_null_terminate:
    mov    byte ptr [edi], 0
    ret    
process endp
               
print_output proc
    invoke StdOut, addr output
    ret    
print_output endp

end main