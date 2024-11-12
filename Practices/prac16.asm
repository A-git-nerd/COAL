section .data
    dividend_low  dw 0x5678            ; Low part of the 64-bit dividend
    dividend_high dw 0x1234            ; High part of the 64-bit dividend
    divisor_low   dw 0x00AB            ; Low part of the 32-bit divisor
    divisor_high  dw 0x0001            ; High part of the 32-bit divisor
    quotient      dq 0                  ; Store quotient (32 bits)
    remainder     dq 0                  ; Store remainder (32 bits)

section .text
start:
    ; Load the 64-bit dividend into DX:AX
    mov ax, [dividend_low]             ; Load low part of dividend (0x5678) into AX
    mov dx, [dividend_high]            ; Load high part of dividend (0x1234) into DX

    ; Load the 32-bit divisor into CX:BX
    mov bx, [divisor_low]              ; Load low part of divisor (0x00AB) into BX
    mov cx, [divisor_high]             ; Load high part of divisor (0x0001) into CX

    ; Check for division by zero
    cmp bx, 0                           ; Check if low part of divisor is zero
    je .divide_by_zero

    ; Step 1: First, perform division
    ; We need to handle the high part (DX) first, which can be larger than BX
    xor dx, dx                          ; Clear DX before division
    ; First, we need to perform the operation to get the appropriate parts
    mov ax, [dividend_low]              ; Move the lower part of dividend to AX
    div bx                               ; Divide AX by BX (result in AX, remainder in DX)

    ; Store lower quotient
    mov [quotient], ax                  ; Store the quotient
    mov ax, dx                           ; Load the remainder (DX)

    ; Step 2: Now handle the high part (DX)
    mov ax, [dividend_high]             ; Load high part of dividend into AX
    mov dx, 0                            ; Clear DX
    div bx                               ; Divide AX by BX

    ; Add to the quotient
    add [quotient], ax                  ; Add to the current quotient
    adc byte [quotient + 2], 0          ; Adjust for carry into higher part (if necessary)

    ; Exit program
    mov ax, 0x4C00                      ; Exit to DOS
    int 21h

.divide_by_zero:
    ; Handle division by zero error
    ; Set an error flag or display an error message here
    mov ax, 0x4C00                      ; Exit
    int 21h
