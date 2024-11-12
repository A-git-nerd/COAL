[org 100h]

jmp start

result dw 0               ; Store the result of base^exp here

power:
    push bp               ; Save base pointer
    mov bp, sp            ; Establish stack frame
    mov ax, [bp+6]        ; Get the exponent (exp) from the stack

    ; Base case: if exp == 0, return 1
    cmp ax, 0
    jne recursive_case    ; If exp != 0, go to recursive case
    mov ax, 1             ; If exp == 0, result is 1
    jmp end_power         ; Jump to end_power to return

recursive_case:
    ; Recursive case: base * power(base, exp - 1)
    mov ax, [bp+4]        ; Load base into AX
    push ax               ; Push base onto the stack (preserving it for recursion)

    dec word [bp+6]       ; Decrement exponent (exp = exp - 1)
    push word [bp+4]      ; Push base onto the stack
    push word [bp+6]      ; Push (exp - 1) onto the stack
    call power            ; Recursive call power(base, exp - 1)
    add sp, 4             ; Clean up the stack after return

    pop bx                ; Restore the original base from the stack
    mul bx                ; Multiply AX by base (AX = AX * BX)

end_power:
    mov sp, bp            ; Restore stack frame
    pop bp                ; Restore base pointer
    ret                   ; Return result in AX

clr:
    ; Clear screen subroutine
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov cx, 2000
    mov ax, 0x0720
    rep stosw
    ret

start:
    call clr              ; Clear screen

    ; Initial call to power with base = 2 and exp = 3 (example: 2^3)
    mov ax, 2
    push ax               ; Push the base (2) onto the stack
    mov ax, 3
    push ax               ; Push the exponent (3) onto the stack
    call power            ; Call the power subroutine
    add sp, 4             ; Clean up the stack after returning from power
    mov [result], ax      ; Store the result from AX in 'result'

    ; Exit program
    mov ax, 4C00h
    int 21h