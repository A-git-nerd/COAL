section .data
    dividend_low  dw 0x1234          ; Low part of the dividend (0x1234)
    dividend_high dw 0x5678          ; High part of the dividend (0x5678)
    divisor_low   dw 0x00AB          ; Low part of the divisor (0x00AB)
    divisor_high  dw 0x0001          ; High part of the divisor (0x0001)
    quotient      dq 0                ; Store quotient
    remainder     dq 0                ; Store remainder

section .text
start:
    ; Load dividend into DX:AX
    mov ax, [dividend_low]           ; AX = 0x1234
    mov dx, [dividend_high]          ; DX = 0x5678

    ; Load divisor into BX:CX
    mov cx, [divisor_low]            ; CX = 0x00AB
    mov bx, [divisor_high]           ; BX = 0x0001

    ; Perform division: DX:AX / BX:CX
    ; Note: Here we will need to handle the division manually, as
    ; we can only divide by the low word directly.

    ; First, check if the high part is zero (BX should not be zero)
    cmp bx, 0
    je .divide_by_zero               ; Handle division by zero if necessary

    ; Step 1: Divide the lower part (AX) by the lower part (CX)
    xor dx, dx                       ; Clear DX before dividing
    div cx                            ; AX / CX, quotient in AX, remainder in DX

    ; Save the lower quotient
    mov [quotient], ax               ; Save quotient (from AX)

    ; Step 2: Multiply the quotient by the high part of the divisor
    ; (for the actual division calculation)
    mov ax, [quotient]               ; Load the current quotient
    mul bx                            ; AX = AX * BX (to adjust for the higher order)

    ; Step 3: Subtract this from the dividend (DX:AX)
    sub dx, ax                       ; DX = DX - (quotient * high part)

    ; Step 4: Handle remainder
    ; Now we have to manage the remainder in DX

    ; The final quotient is in AX, and the remainder in DX
    mov [remainder], dx               ; Store remainder

    ; Exit program
    mov ax, 0x4C00
    int 21h

.divide_by_zero:
    ; Handle the division by zero case here
    ; You can set an error flag or display an error message
    mov ax, 0x4C00
    int 21h
