[org 100h]

mov si,0

loadingNum:
cmp si,[size]
je termination

mov al,[nums+si]

shifting:
cmp si,[size]
je termination

cmp byte [i],8
je checkingParity

shr al,1
jc carryFound

inc byte [i]
jmp shifting

carryFound:
inc byte [countForOddEven]
inc byte [i]
jmp shifting

checkingParity:
mov al,[countForOddEven]
shr al,1
jc oddParity
inc si
mov byte [i],0
mov byte [countForOddEven],0
mov ax,0
jmp loadingNum

oddParity:
mov byte [nums + si],0
inc si
mov byte [i],0
mov byte [countForOddEven],0
mov ax,0
jmp loadingNum


termination:
mov ax,4ch
int 21h

nums:db 0xA7,0xA3,0x94,0xFF,0x00
size:db 5
countForOddEven:db 0
i:db 0