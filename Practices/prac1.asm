[org 100h]

jmp start
message:db 'qoutient:102'
size:dw 12

start:





mov ax,0xb800
mov es,ax
mov di,0
cls:
mov word [es:di],0x0720

add di,2
cmp di,4000
jne cls


mov si,message
mov di,0
mov cx,[size]
mov ah,0x07

nextChar:
mov al,[si]
mov [es:di],ax
add si,1
add di,2

loop nextChar


mov ax,4c00h
int 21h