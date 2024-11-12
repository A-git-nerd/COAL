[org 100h]
jmp TakingKey

message: db 'Enter a character: ', 0
;to store the key character
key: db 0                  
size: db 0

clrSrc:
    push ax
    push es
    push di
    push cx
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax, 0x0720
    mov cx, 2000
    rep stosw
    pop cx
    pop di
    pop es
    pop ax
    ret

; Calculate the length of the message
strlen:
    pusha
    push ds
    pop es
    mov di, message
    mov al, 0
    mov cx, 0xFFFF
    repne scasb
    mov ax, 0xFFFF
    sub ax, cx
    dec ax
    mov [size], ax
    popa
    ret

; Print the message string on screen
printstr:
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x07
    mov dx, 0x0000
    mov cx, [size]
    push cs
    pop es
    mov bp, message
    int 10h
    ret

TakingKey:
    call clrSrc
    call strlen
    call printstr

    ; Taking the key input
    mov ah, 08h            ; service to take key
    int 21h
    mov [key], al          ; store the key character

    ; Display the character entered
    mov ah, 0x0E
    mov al, [key]
    int 10h

    ; Prepare to display ASCII value
    movzx ax, byte [key]   
    call PrintDecimal      ; Convert and print decimal value

    ; Exit program
    mov ax, 4c00h
    int 21h

; Routine to print a decimal number in AX
PrintDecimal:
    pusha
    mov cx, 10             ; Base 10 for decimal
    mov bx, 0              ; Clear BX for digit storage

;dividing the number by base 10 till quotient becomes 0
print_digits:
    xor dx, dx             ; Clear DX for DIV
    div cx                 ; Divide AX by 10, remainder in DX
    add dl, '0'            ; Convert remainder to ASCII character
	;pushed lsb bits
    push dx                ; Store digit on stack
    inc bx                 ; Count number of digits
    or ax, ax              ; Check if quotient is zero
    jnz print_digits       ; Repeat if more digits

print_stack_digits:
;poped msb bits that's why stack is use
    pop dx                 ; Get the digit from the stack
    
	;printing the decimal value that was push in stack earlier  
	mov ah, 0x0E           ; BIOS teletype output
    mov al, dl             ; Load digit to AL
    int 10h                ; Print the digit
    dec bx                 ; Decrement digit counter
    jnz print_stack_digits ; Repeat until all digits are printed
    popa
    ret
