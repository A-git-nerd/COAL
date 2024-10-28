[org 0x0100]
jmp start
arr: dw 1,2,3,4,5,6,7,8,9,10
size: dw 20

ReverseArray:
    push bp
    mov bp, sp
    sub sp, 6 
    mov word[bp-2] , 0 
    mov cx, [bp+4]
    mov word[bp-4] , cx 
    sub word[bp-4], 2
    mov cx, [bp+4]
    shr cx, 2
    mov [bp-6], cx
    mov dx, 0
    mov cx, 0
    mov bx, [bp+6]
    l1:
    cmp cx, [bp-6]
    jae loopend
    add cx, 1

    mov si, bx
    mov di, bx
    add word si, [bp-2]
    add word di, [bp-4]
    mov ax, [si]
    mov dx, [di]
    mov word [si], dx
    mov word [di], ax
    add word[bp-2], 2
    sub word[bp-4], 2
    jmp l1

    loopend:
    add sp, 6
    pop bp
    ret 6
    

start:
push arr
push word [size]
call ReverseArray


mov ax, 0x4c00
int 21
