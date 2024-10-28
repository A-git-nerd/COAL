[org 100h]

mov ax, [num]
test ax, ax
cmp ax, 1
jbe not_prime

mov cx, [num]
mov bx, [iterations]


Prime_Numbers:
mov dx, 0  
mov ax, cx
div word bx
test dx, dx
cmp dx, 0
je not_prime
inc bx

test bx, bx
cmp bx, cx
jge found
jmp Prime_Numbers

not_prime:
mov cx, 0
jmp end

found:
mov cx, 1

end:
mov ax, 4Ch
int 21h

num: dw 30
iterations: dw 2