section .data
    dividend_low  dw 0x5678            ; Low part of the 64-bit dividend
    dividend_high dw 0x1234            ; High part of the 64-bit dividend
    divisor_low   dw 0x00AB            ; Low part of the 64-bit divisor
    divisor_high  dw 0x0001            ; High part of the 64-bit divisor
    quotient      dq 0                  ; Store quotient (64 bits)
    remainder     dq 0                  ; Store remainder (64 bits)

section .text
start:
    ; Load the 64-bit dividend into DX:AX
    mov ax, [dividend_low]             ; Load low part of dividend (0x5678) into AX
    mov dx, [dividend_high]            ; Load high part of dividend (0x1234) into DX

    ; Load the 64-bit divisor into CX:BX
    mov bx, [divisor_low]              ; Load low part of divisor (0x00AB) into BX
    mov cx, [divisor_high]             ; Load high part of divisor (0x0001) into CX

    ; Check for division by zero
    cmp bx, 0                           ; Check if low part of divisor is zero
    je .divide_by_zero

    ; Step 1: Handle the high part first
    xor dx, dx                          ; Clear DX before division
    mov ax, [dividend_high]             ; Move high part of dividend to AX
    div bx                               ; Divide AX by BX
    mov [quotient + 2], ax              ; Store high part of the quotient

    ; Step 2: Now handle the low part
    xor dx, dx                          ; Clear DX
    mov ax, [dividend_low]              ; Move low part of dividend to AX
    div bx                               ; Divide AX by BX

    ; Combine quotient from both divisions
    mov [quotient], ax                  ; Store low part of the quotient
    add [quotient + 2], dx              ; Add the remainder to high part of the quotient

    ; Exit program
    mov ax, 0x4C00                      ; Exit to DOS
    int 21h

.divide_by_zero:
    ; Handle division by zero error
    ; Set an error flag or display an error message here
    mov ax, 0x4C00                      ; Exit
    int 21h
