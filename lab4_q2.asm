[org 100h]

clc               ; Clearing carry flag

loop_start:
    mov ax, [data]   ; Load word from [data] into AX

    ; Swap every adjacent pair of bits in AX
    mov cx, ax          ; Copy AX to CX
    and ax, 0AAAAh      ; Mask to extract odd bits ->101010101010->AAAAAh
    shr ax, 1           ; Shift even bits right by 1
    and cx, 05555h      ; Mask to extract even bits  ->01010101010101->5555h
    shl cx, 1           ; Shift odd bits left by 1
    or ax, cx           ; Combine the two results

    mov [data], ax   ; Store the modified AX back into [data]
    jmp exit      

exit:
    mov ax, 4C00h      
    int 21h

data:
    dw 3059h  