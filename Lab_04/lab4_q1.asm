[org 100h]

jmp start
size: dw 16             ;No of bits
count: dw 1             ;for completion
noOfOnes: dw 0          ;No of ones

start:
mov bx,0xB189           ;loading value

checking_Ones:
shr bx,1                ;shift right to check no of ones
jc carryFound           ;if one found
cmp [count],ax          ;checking its complete or not
je end
inc word [count]        ;increament count
jmp checking_Ones       ;again loop


carryFound:
inc word [noOfOnes]     ;increament no of ones count
mov ax,[size]
cmp [count],ax          ;checking its complete or not
je end
inc word [count]        ;increament count
jmp checking_Ones       ;again loop


end:
mov ax,4ch
int 21h