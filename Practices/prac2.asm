[org 100h]

start:
    ; Prepare to call the printnum subroutine
    mov ax, 1234  ; Number to print
    push ax       ; Pass the number as argument on the stack
	call cls
    call printnum ; Call the subroutine to print the number

    ; Exit the program
    mov ax, 4c00h
    int 21h

; Subroutine to print a number at the top-left of the screen
cls:
mov ax,0xB800
mov es,ax

clr:
mov word [es:di],0x0720
add di,2
cmp di,4000
jne clr

ret

printnum:
    push bp
    mov bp, sp

    ; Save registers
    push es
    push ax
    push bx
    push cx
    push dx
    push di

    ; Set video segment to 0xB800 (for text mode)
    mov ax, 0xb800
    mov es, ax

    ; Load the number to be printed (passed as argument)
    mov ax, [bp+4]  ; Load number into AX
    mov bx, 10      ; Use base 10 for division
    mov cx, 0       ; Initialize count of digits

nextdigit:
    mov dx, 0       ; Clear DX for division
    div bx          ; Divide AX by 10 (result in AX, remainder in DX)
    add dl, 0x30    ; Convert remainder (digit) to ASCII
    push dx         ; Save ASCII digit on stack
    inc cx          ; Increment digit count
    cmp ax, 0       ; Is quotient zero?
    jnz nextdigit   ; If not, divide again

    ; Now display the digits from the stack (in reverse order)
    mov di, 0       ; Set DI to top-left corner of the screen

displaydigits:
    pop dx          ; Get next digit from stack
    mov [es:di], dl ; Store character at video memory location ES:DI
    mov [es:di+1], byte 0x07 ; Set attribute to white text on black background
    add di, 2       ; Move to next character position on screen
    loop displaydigits  ; Repeat for all digits

    ; Restore registers
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop es

    ; Restore base pointer
    pop bp
    ret 2  ; Return, cleaning up 2 bytes (number parameter) from the stack
