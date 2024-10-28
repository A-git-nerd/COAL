[org 100h]

mov si,0 
mov di,0 

start:
mov al,[mainIndex] 
cmp ax,di
je startEnded

mov al,[subIndex] 
cmp ax,si
je startEnded


mov al,[subArray + si]
cmp al,[mainArray + di]
je Matched 

mov si,0 
inc di
mov byte [foundIndex],-1
jmp start

Matched:
cmp si,0  
je indexEqual
inc di 
inc si
jmp start

indexEqual:
mov al,[mainArray+di]
mov [foundIndex],al
inc di
inc si
jmp start


noSubArray:
mov byte [foundIndex],-1
jmp termination

startEnded:
mov al,[subIndex]
cmp ax,si
jne noSubArray
mov dx,[foundIndex]
jmp termination

termination:
mov ax,4ch
int 21h
ret

mainArray: db -3,1,2,5,6,8 
subArray:db -3,1,2,5
mainIndex: db 5 
subIndex: db 3
foundIndex:dw -1 