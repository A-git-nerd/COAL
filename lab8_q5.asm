[org 0x100]
clrScr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax, 0x0720
    mov cx, 2000
    cld
    rep stosw
    jmp main

print:
    push bp          
    mov bp, sp       
    mov bx, 0
    mov ax, 0xb800
    mov es, ax
    mov si, arr
    mov di, [bp+4]
    mov cx, 100
next:
    mov ah, 0x07
    lodsb
    cmp al, 'd'
    jne skip
    mov cl, '$'
    dec si
    mov [si], cl
    inc si
skip:
    cmp al, '0'
    je terminate
    stosw
    jmp next
terminate:
    pop bp           
    ret 2            
main:
    mov ax, 200      
    push ax
    call print
    mov ax, 360      
    push ax
    call print
    mov ax, 0x4c00   
    int 0x21

arr: db 'ddsdfhgrtsdfhjghjksdd0'