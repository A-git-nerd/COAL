[org 0x100]
jmp start
multiplicand :db -12
multiplier :db 1
result :dw 0

start:
mov bx,0
mov cl,8
mov al,[multiplicand]
mov dl,[multiplier]
test al,al
jns below
neg al
add bx,1

below:
test dl,dl
jns checkbit
neg dl
add bx,1

checkbit:
shr dl,1
jnc skip
add [result],al

skip:
shl ax,1
dec cl
jnz checkbit

;if bx 0 or bx 2 then result should positive
cmp bx,2
jne end

cmp bx,0
jne end

neg word[result]

end:
mov ax,0x4c00
int 0x21

