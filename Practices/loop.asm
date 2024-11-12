[org 100h]

mov bx,21

while:
cmp bx,0
je end

dec bx
dec bx
dec bx

jmp while

end:
mov ax,4ch
int 21h