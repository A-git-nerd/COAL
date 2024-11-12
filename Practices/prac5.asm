[org 100h]
jmp start

sum:
push bp
mov bp,sp

mov ax,[bp+6]
mov bx,[bp+4]
add ax,bx

mov [bp-2],ax

mov [bp+8],ax

mov sp,bp
pop bp
ret 4

start:
mov ax,5
mov bx,3

sub sp,2
push bx
push ax

call sum 
pop dx

mov ax , 4ch
int 21h