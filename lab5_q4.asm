[org 100h]
jmp start
rollNum:dw 0x3059
d:dw 0x0
r:dw 0x0

start:
mov ax,[rollNum]
and ax,0x000F

mov bx,[rollNum]
and bx,0x00F0
shr bx,4

mov cx,[rollNum]
and cx,0x0F00
shr cx,8

mov dx,[rollNum]
and dx,0xF000
shr dx,12

add ax,bx
add ax,cx
add ax,dx

shr ax,2

mov [r],ax
add ax,2
mov [d],ax

mov ax,4ch
int 21h