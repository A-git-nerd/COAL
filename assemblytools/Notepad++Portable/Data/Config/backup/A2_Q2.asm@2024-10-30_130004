[org 100h]
jmp start

setup:
mov ax,0xb800
mov ds,ax
mov es,ax
mov dx,0
mov bx,2160
ret

Swapping:
;12 rows
outer:
mov cx,13
mov di,dx 
mov si,bx
inner:
push cx
mov cx,40
;di->0 si->2160
inner2:
mov dx,[ds:di]
push dx
mov dx,[ds:si]
mov [es:di],dx ;es:di <<- ds:si
pop dx
mov [es:si],dx
add di,2
add si,2
loop inner2
pop cx
sub si,80
add si,160
sub di,80
add di,160
loop inner 
ret

start:
call setup
call Swapping

;end
mov ax,4ch
int 21h