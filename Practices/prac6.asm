[org 100h]

cls:
mov ax,0xb800
mov es,ax
mov di,0

clr:
mov word [es:di],0x0720
add di,2
cmp di,4000
jne clr


mov word [es:170],0x0741


mov ax,4ch
int 21h