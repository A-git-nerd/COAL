[org 0x0100]
jmp start ; unconditionally jump over data

num1: dw 5, -4, 3, -2, 1 ; signed data for sorting

start:
mov si, 0

outerloop:
    mov di, si
    add di, 2

innerloop:
    mov ax, [num1+si]      ; load the first number
    cmp ax, [num1+di]      ; compare it with the next number
    jl noswap              ; if ax < num1[di], jump to noswap (signed comparison)  for signed we use jl-> less  and for unsigned we use jb -> below
    
    mov dx, [num1+di]      ; swap if necessary
    mov [num1+si], dx
    mov [num1+di], ax

noswap:
    add di, 2              ; move to the next pair
    cmp di, 10
    jb innerloop

    add si, 2              ; move to the next element in outer loop
    cmp si, 8
    jb outerloop

mov ax, 0x4c00            ; terminate program
int 0x21