[org 100h]

jmp start
count:dw 1
size :dw 16
complement_Need: dw 7
Original_Bin: dw 9
start:
mov ax,0xABA5

complementing:
shr ax,1
jnc complementing


end:
mov ax,4ch
int 21h