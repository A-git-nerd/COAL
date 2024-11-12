[org 100h]

jmp start

result dw 0               ; Store the factorial result here

fact:
    push bp               ; Save base pointer
    mov bp, sp            ; Establish stack frame
    mov ax, [bp+4]        ; Get the parameter n from the stack

    ; Base case: if n == 0 or n == 1, return 1
    cmp ax, 1
    jbe end_fact          ; If n <= 1, jump to end_fact (return 1)
    
    ; Recursive case: n * fact(n - 1)
    dec ax                ; n = n - 1
    push ax               ; Push (n - 1) onto the stack
    call fact             ; Recursive call fact(n - 1)
    add sp, 2             ; Clean up the stack after return

    mov bx, [bp+4]        ; Load original n from stack (still in bp+4)
    mul bx                ; AX = AX * BX, i.e., n * fact(n - 1)

end_fact:
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

    ; Initial call to fact with n = 5 (example)
    mov ax, 5
    push ax               ; Push the argument (n = 5) onto the stack
    call fact             ; Call the fact subroutine
    add sp, 2             ; Clean up the stack after returning from fact
    mov [result], ax      ; Store the result from AX in 'result'

    ; Exit program
    mov ax, 4C00h
    int 21h
