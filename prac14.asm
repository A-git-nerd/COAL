section .data
    low_part  dw 0x1234       ; Lower 16 bits (0x1234)
    high_part dw 0x5678       ; Upper 16 bits (0x5678)
    divisor    dw 0x00AB      ; 16-bit divisor (0x00AB)
    quotient   dw 0            ; Variable to store the quotient
    remainder  dw 0            ; Variable to store the remainder

section .text
start:
    ; Load the low part into AX and the high part into DX
    mov ax, [low_part]         ; AX = 0x1234
    mov dx, [high_part]        ; DX = 0x5678

    ; Load the divisor into BX
    mov bx, [divisor]          ; BX = 0x00AB

    ; Perform the division
    div bx                      ; DX:AX divided by BX

    ; After DIV:
    ; - Quotient (Q) is in AX
    ; - Remainder (R) is in DX
    mov [quotient], ax         ; Store the quotient
    mov [remainder], dx        ; Store the remainder

    ; Exit program
    mov ax, 0x4C00
    int 21h
