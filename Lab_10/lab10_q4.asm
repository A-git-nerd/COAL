[org 0x0100]
jmp start

counter: dw 0

TimerFunction:
push ax
add word [cs:counter],1
push word [cs:counter]
call print
mov al, 0x20
out 0x20, al
pop ax
iret

keyboardFunction:
push ax
in al, 0x60
cmp al, 0x10
je disable
cmp al, 0x90
je enable_TimerFunction
jmp returning

disable:
in al, 0x21
or al, 0x01
out 0x21, al
jmp returning

enable_TimerFunction:
in al, 0x21
and al, 0xFE
out 0x21, al

returning:
mov al, 0x20
out 0x20, al
pop ax
iret


print:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax
mov ax, [bp+4]
mov bx, 10
mov cx, 0

nextdigit:
mov dx, 0
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jnz nextdigit
mov di, 140

nextposition:
pop dx
mov dh, 0x07
mov [es:di], dx
add di, 2
loop nextposition
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2





start:
mov ax,0
mov es, ax

cli

mov word [es:8*4], TimerFunction
mov [es:8*4+2], cs

mov word [es:9*4], keyboardFunction
mov [es:9*4+2], cs

sti

mov dx, start
add dx, 15
mov cl, 4
shr dx, cl

mov ax, 0x3100
int 0x21
