section .data
first:   dq 0x12345678, 0x9ABCDEF0    ; 64-bit number A
second:  dq 0x56789ABC, 0xDEF01234    ; 64-bit number B
result:  dq 0, 0, 0, 0               ; 128-bit result initialized to 0

section .text

start:
    ; Multiply A_low_low * B_low_low
    mov ax, [first]            ; A_low_low
    mul word [second]          ; B_low_low
    mov [result], ax           ; Store lower 16 bits in result
    mov [result+2], dx         ; Store higher 16 bits of result

    ; Multiply A_low_high * B_low_low
    mov ax, [first+2]          ; A_low_high
    mul word [second]          ; B_low_low
    add [result+2], ax         ; Add to the result (at offset +2)
    adc [result+4], dx         ; Add carry to the next part of the result

    ; Multiply A_low_low * B_low_high
    mov ax, [first]            ; A_low_low
    mul word [second+2]        ; B_low_high
    add [result+2], ax         ; Add to the result (at offset +2)
    adc [result+4], dx         ; Add carry to the next part of the result

    ; Multiply A_low_high * B_low_high
    mov ax, [first+2]          ; A_low_high
    mul word [second+2]        ; B_low_high
    add [result+4], ax         ; Add to the result (at offset +4)
    adc [result+6], dx         ; Add carry to the next part of the result

    ; Multiply A_high_low * B_low_low
    mov ax, [first+4]          ; A_high_low
    mul word [second]          ; B_low_low
    add [result+4], ax         ; Add to the result (at offset +4)
    adc [result+6], dx         ; Add carry to the next part of the result

    ; Multiply A_high_low * B_low_high
    mov ax, [first+4]          ; A_high_low
    mul word [second+2]        ; B_low_high
    add [result+6], ax         ; Add to the result (at offset +6)
    adc [result+8], dx         ; Add carry to the next part of the result

    ; Multiply A_high_high * B_low_low
    mov ax, [first+6]          ; A_high_high
    mul word [second]          ; B_low_low
    add [result+6], ax         ; Add to the result (at offset +6)
    adc [result+8], dx         ; Add carry to the next part of the result

    ; Multiply A_high_high * B_low_high
    mov ax, [first+6]          ; A_high_high
    mul word [second+2]        ; B_low_high
    add [result+8], ax         ; Add to the result (at offset +8)
    adc [result+10], dx        ; Add carry to the next part of the result

    ; Multiply A_low_low * B_high_low
    mov ax, [first]            ; A_low_low
    mul word [second+4]        ; B_high_low
    add [result+2], ax         ; Add to the result (at offset +2)
    adc [result+4], dx         ; Add carry to the next part of the result

    ; Continue with the rest of the combinations for the full multiplication

    ; Exit program
    mov ax, 0x4C00
    int 21h
