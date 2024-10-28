[org 100h]
jmp start

message:db 'Muhammad_Ahmad'
size:dw  14

start:
mov ax,0xb800
mov es,ax
mov di,0
mov si,0

l2:

mov ah,0x87
mov al,[message+si]
mov word [es:di],ax
add di,200
add si,1
dec word[size]
cmp word[size],0
jne l2

mov ax,4ch
int 21h