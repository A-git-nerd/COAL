[org 100h]
mov cx,5
start:
cmp cx,1
loopne start

end:
mov ax, 4ch
int 21h
num: dq 0x981, 0x5221757,0x8737923
