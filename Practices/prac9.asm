[org 0x100]
jmp start
height: dw 8
base: dw 8
Xpos: dw 0
Ypos: dw 0

clearScreen:
push si
mov si,0
nextchar:
mov word[es:si],0x0720
add si,2
cmp si,4000
jl nextchar
pop si
ret

delay:
push cx
mov cx, 0X000F ; change the values to increase delay time
delay_loop1:
push cx
mov cx, 0xFFFF
delay_loop2:
loop delay_loop2
pop cx
loop delay_loop1
pop cx
ret
;===============================================
;===================D D========================
;===============================================
GetScrPos:
push ax
push bx

mov ax,0x0000
mov bx,0x0000

mov al,[Ypos] ; getting y position
mov bl,80
mul bl
mov bl,[Xpos] ; getting x position

add ax,bx
shl ax,1
mov si,ax
pop bx
pop ax
ret 

PrintTriangle:
PUSH dx
mov bx,0
call GetScrPos

print:
call delay
call GetScrPos
mov word[es:si],0x022A
mov word[es:bx],0x022A
add word[Xpos],1
add word[Ypos],1
call GetScrPos
add bx,160
mov dx,[Ypos]
cmp dx,[height]
jl print

baseprint:
call delay
mov word[es:bx],0x022A
mov word[es:si],0x022A
sub si,2
add bx,2
cmp bx,si
jng baseprint

pop dx
ret

start:
mov ax,0xb800
mov es,ax
;call clearScreen
call PrintTriangle


End:mov ax,0x4c00
int 0x21