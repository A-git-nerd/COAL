[org 100h]
jmp start
h: dw 8
base: dw 14
count: dw 3
row:dw 0

delay:
push cx
mov cx,0x000F
l1:
push cx
mov cx,0xFFFF
l2:
loop l2
pop cx
loop l1
pop cx
ret

clr:
mov ax,0xb800
mov es,ax
mov di,0

cls:
mov word [es:di],0x0720
add di,2
cmp di,4000
jne cls
ret

drawTriangle:
mov ax,0xb800
mov es,ax
mov di,0
mov word [es:di],0x022A
call delay
inc word[row]
mov bx ,160
mov ax,[row]
mul bx

mov di,ax

mov word [es:160],0x022A
call delay

mov di,164
mov word [es:164],0x022A
call delay

dec word[h]
dec word[h]

l11:
inc word[row]
mov bx ,160
mov ax,[row]
mul bx

mov di,ax

mov word [es:di],0x022A
call delay

mov ax,[count]
add ax,1
mov bx,2
mul bx
add di,ax


mov word [es:di],0x022A
call delay

dec word [h]
mov ax,[h]
inc word [count]
inc word [count]
cmp ax ,1
jne l11

l233:
inc word[row]
mov bx ,160
mov ax,[row]
mul bx

mov di,ax
mov cx, [base]
l22:

mov word [es:di],0x022A
call delay

add di,2
loop l22
ret

start:
call clr
call drawTriangle

mov ax,4ch
int 21h