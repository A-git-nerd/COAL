[org 100h]
jmp start
num1: dq 0x00, 0x00 , 0x12345678,0x87654321   ;64bits
num2: dq 0x00, 0x00 , 0x12345678,0x87654321   ;64bits
res: dq 0x0,0x0,0x0,0x0          ;128bits

start:
mov word cx ,64

checkbit:
shr [num1+12],1
rcr [num1+8],1
jnc skip

mov ax,[num1]

mov ax,4ch
int 21h