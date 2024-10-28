[org 0x100]
jmp start
Subtract:
push bp
mov bp,sp
push si
mov ax,[bp+10]
mov bx,[bp+8]
sub ax,bx

mov bx,[bp+6]
sub ax,bx

mov bx,[bp+4]
sub ax,bx

pop si
pop bp

ret 8


start:
sub sp,2
; function call Test i
push 0xA
Push 0x1
Push 0x2
Push 0x2
Call Subtract
pop bx

; function call Test ii
push 0x9
Push 0x1
Push 0x5
Push 0x0
Call Subtract
pop bx

; function call Test iii
push 0xF
Push 0x1
Push 0x8
Push 0x4
Call Subtract
pop bx

end:
mov ax,0x4c00
int 0x21
