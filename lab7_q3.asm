[org 0x100]
clear:
mov ax,0xB800
mov es,ax
mov di,0
next2:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne next2
jmp start

movingstar:
mov bx,0
mov al,80
mul byte[currrow]
mov bl,[currcol]
add ax,bx
shl ax,1
mov di,ax
mov word[es:di],0x072A
ret

mainloop:

call movingstar
call delay
mov word[es:di],0x0720
inc byte[currcol]
cmp byte[currcol],80
jne below
mov byte[currcol],0
inc byte[currrow]
cmp byte[currrow],25
jge below2
below:
jmp mainloop
below2:
ret

delay:
push cx
mov cx, 3 ; change the values to increase delay time
delay_loop1:
push cx
mov cx, 0xFFFF
delay_loop2:
loop delay_loop2
pop cx
loop delay_loop1
pop cx
ret

start:
mov ax,0xB800
mov es,ax
call mainloop



end:
mov ax,0x4c00
int 0x21
currrow:db 1
currcol:db 0