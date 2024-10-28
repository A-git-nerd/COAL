[org 0x100]
jmp start
arr: dw 0x0001,0x0002,0x0007,0x0004,0x0005
sized: dw 10

maxdiff:
push si ;will iterate in array
push bp
mov bp,sp
mov si,bp

push bx
sub sp,2
mov bx,sp ; having big number
mov word[bx],0

push di
sub sp,2
mov di,sp       ; having smallnumber
mov word[si],0

mov si,[bp+8]  ;initializing base address to si
mov dx,0       ;[bp+6] initializing size to dx
xor ax,ax




loop1:cmp ax,[si]
jl update1
traversing:add dx,2
add si,2
cmp dx,[bp+6]
je next
jmp loop1
update1:mov ax,[si]
jmp traversing
next:
mov [bx],ax


mov si,[bp+8]  ;initializing base address to si
mov dx,0       ;[bp+6] initializing size to dx
xor ax,ax

mov ax,[si]
loop2:cmp ax,[si]
jg update2
traversing2:add dx,2
add si,2
cmp dx,[bp+6]
je next2
jmp loop2
update2:mov ax,[si]
jmp traversing2

next2:mov [di],ax
mov ax,[bx]
mov [bp+10],ax
mov ax,[di]
sub [bp+10],ax
add sp,2
pop di
add sp,2
pop bx
pop bp
pop si
ret 4





start:
mov ax,0x0000
mov bx,0x0000
mov cx,0x0000
mov dx,000000
sub sp,2
push arr
push word[sized]
call maxdiff
pop ax

mov ax,0x4c00
int 0x21
