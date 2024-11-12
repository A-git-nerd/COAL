[org 0x100]
jmp start
size:dw 10
count:dw 1
row: dw 0
tempSize: dw 8

start:

cls:
mov ax,0xb800
mov es,ax

mov di,0

clr:
mov word [es:di],0x0720
add di,2
cmp di,4000
jne clr

print:
mov ax,[size]
mov bx,2
mul bx ;bx * ax =ax
mov di,ax

mov ax,[row]

mov bx,160
mul bx

add di,ax
inc word [row]
mov cx,[count]
printing:
mov word [es:di],0x0741
add di,2
loop printing

dec word [size]
mov dx,2
add word [count],dx

mov dx,[size]
cmp dx,0
jne print



print2:
mov ax,[tempSize]
mov [size],ax
inc word [size]
dec word [count]
dec word [count]
dec word [count]
dec word [count]

calc:
mov ax,[tempSize]
add ax,1
sub ax,[size]
add ax,2
mov bx,2
mul bx ;bx * ax =ax
mov di,ax

mov ax,[row]

mov bx,160
mul bx

add di,ax

inc word [row]
mov cx,[count]
printing2:
mov word [es:di],0x0741
add di,2
loop printing2

dec word [size]
mov dx,2
sub word [count],dx

mov dx,[size]
cmp dx,0
jne calc

mov ax,0x4c00
int 0x21