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
	result_odd            db "и нечетное ", 0
    result_even           db "и четное ", 0
    result_not_positive   db "Число не положительное ", 0
    result_positive       db "Число положительное ", 0

	format                db "%d", 0
.data?
	number_               dd ?
.code
main:
    invoke crt_printf, addr prompt_number
    invoke crt_scanf, addr format, addr number_
    mov        ebx, number_
    cmp        ebx, 0
    jle        on_not_positive

on_positive:
    invoke crt_printf, addr result_positive
    jmp        check_mod   
     
on_not_positive:
    invoke crt_printf, addr result_not_positive 

check_mod:
    mov        eax, ebx
    mov        ebx, 2
    cdq
    idiv       ebx
    or         edx, edx
    jz         on_even

on_odd:
    invoke crt_printf, addr result_odd
    jmp        end_program

on_even:
    invoke crt_printf, addr result_even

end_program:
    invoke            ExitProcess, 0

end main