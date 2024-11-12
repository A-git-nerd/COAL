[org 100h]
jmp start
msg1: db 'My name is',0
msg2: db 'I am in coal lab',0
msg3: db 'Learning assembly language',0

strlen1:
mov cx,0xFFFF
mov al,0
mov di,msg1
push ds
pop es
repne scasb
mov ax,0xFFFF
sub ax,cx
ret


strlen2:
mov cx,0xFFFF
mov al,0
mov di,msg2
push ds
pop es
repne scasb
mov ax,0xFFFF
sub ax,cx
ret


strlen3:
mov cx,0xFFFF
mov al,0
mov di,msg3
push ds
pop es
repne scasb
mov ax,0xFFFF
sub ax,cx
ret


start:
clrSrc:
mov ax,0xb800
mov es,ax
mov di,0
mov ax,0x0720
mov cx,2000
rep stosw

print:

call strlen1
mov cx,ax

mov ah,13h
mov al,1

mov bh,0
mov bl,0x07

mov dx,0x0000

mov bp,msg1
int 10h


call strlen2
mov cx,ax

mov ah,13h
mov al,1

mov bh,0
mov bl,0x07

mov dx,0x0100
mov bp,msg2

int 10h

call strlen3
mov cx,ax

mov ah,13h
mov al,1

mov bh,0
mov bl,0x07

mov dx,0x0200
mov bp,msg3

int 10h

mov ax,4ch
int 21h