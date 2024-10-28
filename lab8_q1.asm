[org 100h]

start:
mov ax,0xb800

mov es,ax    ;printing
mov ds,ax    ;for storing

mov di,1920
mov si,0
mov cx,960

rep movsw

end:
mov ax,4ch
int 21h