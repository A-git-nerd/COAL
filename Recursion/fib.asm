[org 100h]

jmp start

result dw 0               ; Store the result here

fibo:
    push bp               ; Save base pointer
    mov bp, sp            ; Establish stack frame
    mov ax, [bp+4]        ; Get the parameter x from stack

    ; Base case: if x == 1 or x == 0, return x
    cmp ax, 1
    jbe end_fibo          ; If x <= 1, jump to end_fibo (return x)

    ; Recursive case: calculate fib(x-1) + fib(x-2)
    dec ax                ; x = x - 1
    push ax               ; Push (x-1) onto the stack
    call fibo             ; Recursive call fib(x-1)
    add sp, 2             ; Clean up the stack after return
    push ax               ; Save the result of fib(x-1)

    mov ax, [bp+4]        ; Reload x from stack
    sub ax, 2             ; x = x - 2
    push ax               ; Push (x-2) onto the stack
    call fibo             ; Recursive call fib(x-2)
    add sp, 2             ; Clean up the stack after return

    pop bx                ; Retrieve fib(x-1) result from stack
    add ax, bx            ; Add fib(x-1) and fib(x-2)

end_fibo:
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

    ; Initial call to fibo with x = 7
    mov ax, 7
    push ax               ; Push the argument (x = 7) onto the stack
    call fibo             ; Call the fibo subroutine
    add sp, 2             ; Clean up the stack after returning from fibo
    mov [result], ax      ; Store the result from AX in 'result'

    ; Exit program
    mov ax, 4C00h
    int 21h