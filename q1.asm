[org 100h]

mov ax,0
mov bx,0
mov cx,0
mov dx,0

mov ax,[num] ;loading number
test ax,ax
js Negative

mov dx,0
mov ax,[num]
div word [divisor]
test dx,dx
cmp dx,0
jne Div

mov bx,1
jmp end

Negative:
mov bx,0 
jmp end

Div:
mov bx,0
end:
mov ax,4ch
int 21h
num: dw -24
divisor:dw 2
