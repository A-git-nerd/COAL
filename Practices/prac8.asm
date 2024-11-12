[org 100h]

jmp start
SubTract:
push bp
mov bp,sp
mov dx,[bp+4]
mov cx,[bp+6]
mov bx,[bp+8]
mov ax,[bp+10]

sub ax,bx
sub ax,cx
sub ax,dx

mov word [bp+12],ax
mov sp,bp
pop bp

ret 8
Func:
push bp
mov bp,sp
sub sp,4 ; making l1 and l2

push word [bp+4]
push word [bp+6]
push word [bp+8]
push word [bp+10]

call SubTract
mov ax,[bp-4]
mov [bp-2],ax

push word [bp+8]
push word [bp+10]
push word 0
push word 0
call SubTract

mov ax,[bp-2]
add ax,[bp-4]

mov word [bp+12],ax

mov sp,bp
pop bp
ret 8

start:
sub sp,2
mov ax,0xA
mov bx,0x1
mov cx,0x2
mov dx,0x2
push dx
push cx
push bx
push ax

call Func

pop bx



mov ax,4ch
int 21h