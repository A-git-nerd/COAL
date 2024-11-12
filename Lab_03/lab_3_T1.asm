[org 100h]

mov ax, [num]      ; Load the number into AX
cmp ax, 0          ; Compare AX (the number) with 0
js end             ; If the number is negative (sign flag set), jump to end

mov dx, 0          ; Clear DX for division , otherwise it will store garbage value
mov ax, [num]      ; Reload the number into AX
div word [divisor] ; Divide AX by divisor (2) to check if even

cmp dx, 0          ; Check remainder in DX, if it's 0, the number is even
jne end            ; If the remainder is not zero, jump to end

mov ax, 1          ; The number is both positive and even, store 1 in AX
jmp last           ; Jump to the last part of the code

end:
mov ax, 0          ; If either condition is not met, store 0 in AX

last:
mov ax, 4Ch        ; Terminate program
int 21h           

num: dw 24         
divisor: dw 2