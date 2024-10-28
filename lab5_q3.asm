[org 100h]

jmp start
num1:dw 0x0102
quotient:dw 0x00
reminder:dw 0x00
start:
mov ax,[num1]

finding:
cmp ax,0xA
jl end

sub ax,0xA
inc word[quotient]
jmp finding

end:
mov [reminder],ax
mov ax,4ch
int 21h