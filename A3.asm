[org 0x100]

mov ax,0xF08F ;loading number
count: dw 0 ;need to do operation on only 8bits numbers 8+8 =16bit numbers
taking_ah_bit: ;load half number (ah)
cmp word [count],8 ;8bit number in ah
je palindrome

inc word [count]
shl ah,1 ;taking MSB bit 
jc found_a_carry_of_ah ;if cf=1 then bx=1

mov bx,0 ;else bx=0

jmp taking_al_bit ;loading rest of half number in al


found_a_carry_of_ah:
mov bx,1
jmp taking_al_bit


taking_al_bit: ;loading rest of half number in al
shr al,1 ;taking lsb bit
jc found_a_carry_of_al ;if cf =1 then cx=1
mov cx,0 ;else cx=0

jmp comparison

found_a_carry_of_al:
mov cx,1
jmp comparison

comparison: ;comparing msb and lsb (bx and cx) 
cmp bx,cx
jne not_palindrome ;not equal end program not palindrome

jmp taking_ah_bit ;else taking other bits

palindrome: ;at the end number is palindrome when loop terminates
mov dx,1
jmp end

not_palindrome:
mov dx,0

end:
mov ax,0x4c00
int 0x21