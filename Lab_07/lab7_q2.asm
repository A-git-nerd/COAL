[org 0x100]
clear:
mov ax,0xB800
mov es,ax
mov di,0
next:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne next


mov ax,0xB800
mov es,ax
push word[topl]
push word[topr]
push word[bottoml]
push word[bottomr]




drawrect:
push bp
mov bp,sp
mov ax,[bp+8]
mov bx,[bp+6]
mov cx,[bp+4]
mov dx,[bp+2]
mov di,ax
l1:
mov word[es:di],0x072B
add di,2
cmp di,bx
jng l1
mov di,ax
mov si,bx

l2:
add di,160
mov word[es:di],0x072B
add si,160
mov word[es:si],0x072B
cmp di,cx
jnge l2
mov di,cx

l3:
mov word[es:di],0x072B
add di,2
cmp di,dx
jng l3



mov ax,0x4c00
int 0x21
topl:dw 840
topr:dw 880
bottoml:dw 1640
bottomr:dw 1680