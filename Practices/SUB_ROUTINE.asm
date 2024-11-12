[org 100h]
jmp start
startpoint:dw 0
endpoint:dw 0
A:dw 7,8
B:dw 10,11
widthw:dw 0
height:dw 0

print:
push bp
mov bp,sp
sub sp,2 ;local variable
mov ax,0xb800
mov es,ax
mov di,[bp+4]
mov ax,[di]
;mov ax,[bp+4] ;height

mov di,[bp+6]
mov bx,[di]
;mov bx,[bp+6] ;widthw

mov di,[bp+10]
mov dx,[di]
;mov dx,[bp+10] ;startpoint


mov di,dx
mov ax ,0x0741
mov cx,bx
rep stosw
ret 8

clr:
mov ax,0xb800
mov es,ax
mov di,0
mov cx,2000
mov ax,0x0720
rep stosw
ret

start:
call clr
;B-A
mov ax,[A]
mov bx,[B]
sub bx,ax
mov [widthw],bx

mov ax,[A+2]
mov bx,[B+2]
sub bx,ax
mov [height],bx

mov ax,80
mov bx,[A]
mul bx
mov cx,[A+2]
add ax,cx
mov bx,2
mul bx
mov [startpoint],ax

mov ax,80
mov bx,[B]
mul bx
mov cx,[B+2]
add ax,cx
mov bx,2
mul bx
mov [endpoint],ax

push startpoint
push endpoint
push height
push widthw
call print

mov ax,4ch
int 21h