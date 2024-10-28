[org 100h]

mov ax,0xA425

FirstTwoBits:
cmp word [i],7
je palindrome

inc word [i]
shl ah,1
jc carryFlagFTBits

mov dx,0

jmp ThirdForthBits


carryFlagFTBits:
mov dx,1
jmp ThirdForthBits


ThirdForthBits:
shr al,1
jc carryFlagTFBits
mov cx,0

jmp equality

carryFlagTFBits:
mov cx,1
jmp equality

equality:
cmp dx,cx
jne notPalindrome

jmp FirstTwoBits

palindrome:
mov dx,1
jmp termination

notPalindrome:
mov dx,0

termination:
mov ax,4ch
int 21h

i: dw 0