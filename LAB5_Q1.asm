[org 100h]

start:
mov cx,0
mov ax,[num1 + 8]
mov cx,[num2 + 8]
add ax,cx
mov [result+8],ax

mov ax,[num1+10]
mov cx,[num2+10]
add ax,cx
mov [result+10],ax

mov ax,[num1+12]
mov cx,[num2+12]
add ax,cx
mov [result+12],ax

mov ax,[num1+14]
mov cx,[num2+14]
add ax,cx
mov [result+14],ax

mov ax,[num1+0]
mov cx,[num2+0]
add ax,cx
mov [result+0],ax

mov ax,[num1+2]
mov cx,[num2+2]
add ax,cx
mov [result+2],ax

mov ax,[num1+4]
mov cx,[num2+4]
add ax,cx
mov [result+4],ax

mov ax,[num1+6]
mov cx,[num2+6]
add ax,cx
mov [result+6],ax

mov ax,4ch
int 21h

num1:dd 0x11111111,0x11111111
num2:dd 0x11111111,0x11111111
result:dd 0x00000000