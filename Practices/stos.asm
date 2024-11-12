[org 0x100]
jmp start

scrollUp:
push bp
mov bp,sp
mov ax, 80
mul byte [bp+4]
mov si,ax
push si
shl si, 1
mov cx, 2000
sub cx, ax
mov ax, 0xB800
mov es, ax
mov ds,ax
mov di,0
cld
rep movsw
mov ax, 0x720
pop cx
rep stosw
pop bp
ret 2




start:
mov ax, 5 ;number of lines to scroll
push ax
call scrollUp
mov ax, 0x4C00
int 21h