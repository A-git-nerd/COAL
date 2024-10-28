[org 0x100]
; You have to run three test cases like this:
jmp start

subtract:
push bp
mov bp,sp
mov ax,[bp+10]
mov bx,[bp +8]
sub ax,bx
mov bx,[bp +6]
sub ax,bx
mov bx,[bp +4]
sub ax,bx
mov [bp+12],ax
pop bp
ret 8


pop bp
ret 8



AnotherFunction:
push bp
mov bp,sp
push si
mov si,sp
add si,14 ; si holding results now



sub sp,2 ; reserving space for a local var
mov bp,sp

mov word[si],0
mov word[bp],0


push word[bp+14]
push word[bp+12]
push word[bp+10]
push word[bp+8]

call subtract
mov ax,[bp]
mov word[bp],0
mov [si],ax


push word[bp+10]
push word[bp+8]
push 0x00
push 0x00
call subtract
pop ax
add [si],ax
add sp,4
ret 8


start:

; function call Test i
sub sp,2
push 0xA
Push 0x1
Push 0x2
Push 0x2
Call AnotherFunction
Pop AX ;verify answer here


; function call Test ii
sub sp,2
push 0x9
Push 0x1
Push 0x5
Push 0x0
Call AnotherFunction
Pop AX ;verify answer here

; function call Test iii
sub sp,2
push 0xF
Push 0x1
Push 0x8
Push 0x4
Call AnotherFunction
Pop AX ;verify answer here


;Termination Code here
end:mov ax,0x4c00
int 0x21