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
	prompt_number         db "Введите число а: ", 0
	result_fibonacci      db "Число а является членом последовательности Фибоначи", 0
    result_not_fibonacci  db "Число а не является членом последовательности Фибоначи", 0
   
	format                db "%d", 0
.data?
	number_               dd ?

.code
main:
    invoke crt_printf, addr prompt_number
    invoke crt_scanf, addr format, addr number_
    mov        eax, 1
    mov        ebx, 1

find_fibonacci_loop:
    cmp        ebx, number_
    je         is_fibonacci
    jg         is_not_fibonacci
    mov        ecx, eax
    add        eax, ebx  
    mov        ebx, ecx
    jmp        find_fibonacci_loop

is_fibonacci:
    invoke     crt_printf, addr result_fibonacci
    jmp        end_program

is_not_fibonacci:
    invoke     crt_printf, addr result_not_fibonacci

end_program:
    invoke      ExitProcess, 0

end main


        