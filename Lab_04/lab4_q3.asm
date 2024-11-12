[org 100h]

clc               ; Clearing carry flag
    

loop_start:
    mov ax, [data]   ; Load word from [data] into AX

    ; Swap nibbles in the lower byte
    mov cx, ax          ; Copy AX to CX
    and ax, 0F0F0h      ; Mask to isolate upper nibbles -> 1111 0000 1111 0000
    shr ax, 4           ; Shift the upper nibbles to the lower nibble positions because its 4 bits nibble
    and cx, 0F0Fh       ; Mask to isolate lower nibbles ->0000 1111 0000 1111 
    shl cx, 4           ; Shift the lower nibbles to the upper nibble positions
    or ax, cx           ; Combine the results to get swapped nibbles

    mov [data], ax   ; Store the modified AX back into [data]

    jmp exit     

exit:
    mov ax, 4C00h     
    int 21h

data:
    dw 3059h
