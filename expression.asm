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
	prompt_a     db "Введите значение a: ", 0
	prompt_b     db "Введите значение b: ", 0
	prompt_c     db "Введите значение c: ", 0
	prompt_d     db "Введите значение d: ", 0
	result       db "Результат x: %d", 0
	
	format  db "%d", 0
.data?
	a_          dd ?
	b_          dd ?
	c_          dd ?
	d_          dd ?
	x_          dd ?
 
.code
main:
		invoke crt_printf, addr prompt_a
		invoke crt_scanf, addr format, addr a_

	    invoke crt_printf, addr prompt_b
	    invoke crt_scanf, addr format, addr b_

	    invoke crt_printf, addr prompt_c
        invoke crt_scanf, addr format, addr c_

	    invoke crt_printf, addr prompt_d
        invoke crt_scanf, addr format, addr d_

		;Calculate X = 4a - (b+c) /d
        ;b+c
		mov    eax, b_
        add    eax, c_

        ;(b+c)/d
		;dividient must be x2 size of divisior
        ;cdq (cwd) transform eax (ax) 32 (16) bit to 64 (32) bit eax:edx (ax:dx)
        ;idiv using for division of signed numbers, for 16bit: quotient stored in ax, remainder in dx (for 32 - eax & edx). 
        ;divisior is any REGISTER, divident stored in ax (eax..)
        mov    ebx, d_
        cdq
        idiv   ebx

		;4*a
        mov    ebx, a_
        imul   ebx, ebx, 4 
        sub    ebx, eax
        mov    x_, ebx

	    invoke crt_printf, addr result, x_
	    invoke            ExitProcess, 0
end main