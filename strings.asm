.586
.model flat, stdcall
option casemap:none

includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
include \masm32\include\msvcrt.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

.data
    prompt_string       db "Введите строку: ", 0
    
    input               db 256 dup(0)
    output              db 256 dup(0)

.code
main:      
    invoke crt_printf, addr prompt_string
    invoke StdIn, addr input, 256
                
    lea    esi, input
    lea    edi, output  

process_string:
    mov    al, byte ptr [esi]
    test   al, al
    jz     end_program
    cmp    al, ' '
    je     on_space

store_symbol:
    mov    [edi], al
    inc    edi
    inc    esi
    jmp    process_string

on_space:
    mov    bl, byte ptr [edi-1]
    cmp    bl, al
    jne    store_symbol
    inc    esi
    jmp    process_string

end_program:       
    ;Null-terminate the letters and digits strings
    mov    byte ptr [edi], 0
    invoke StdOut, addr output
    invoke ExitProcess, 0

end main