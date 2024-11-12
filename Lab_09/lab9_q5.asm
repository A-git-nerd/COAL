[org 0x0100]

jmp start
s:db' '

setup:
mov ah,0x13
mov al,1

mov bh,0
mov bl,0x07

mov cx,1

mov dx,0x000
mov bp,s
int 10h

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
; Data section for the counter
counter dw 0

; Interrupt Service Routine for INT 0x60
isr_60:
    ; Save registers
    push ax
    push bx
    push cx
    push dx

    ; Increment the counter in memory
    mov ax, [counter]
    inc ax
    mov [counter], ax

    ; Convert the counter to hexadecimal for display
    mov bx, ax         ; Move counter value to BX for conversion

    ; Display the high nibble
    mov cl, 4          ; Shift to get the high nibble
    mov al, bl         ; Load lower byte of BX (counter)
    shr al, cl
    call display_hex

    ; Display the low nibble
    mov al, bl
    and al, 0x0F       ; Mask out the high nibble
    call display_hex

    ; Restore registers
    pop dx
    pop cx
    pop bx
    pop ax

    ; Return from interrupt
    iret

; Subroutine to display a hexadecimal digit (AL should contain a hex digit 0-F)
display_hex:
    add al, '0'              ; Convert to ASCII
    cmp al, '9'
    jbe display_done         ; If <= '9', it's valid as is
    add al, 7                ; Adjust for 'A'-'F'

display_done:
    mov ah, 0x0E             ; BIOS Teletype function
    int 0x10                 ; Display character in AL
    ret

; Main Program
start:
call clrSrc
call setup
    ; Install our ISR at interrupt vector 0x60
    cli                      ; Disable interrupts temporarily
    xor ax, ax
    mov es, ax               ; Set ES to 0 (IVT base)
    mov word [es:0x60 * 4], isr_60   ; Set offset of ISR in IVT
    mov word [es:0x60 * 4 + 2], cs   ; Set segment of ISR in IVT
    sti                      ; Re-enable interrupts

    ; Trigger INT 0x60 multiple times to test the ISR
trigger_loop:
    mov ah, 0x0E
    mov al, '('
    int 0x10                 ; Display '-' before each interrupt
    int 0x60   

 mov ah, 0x0E
    mov al, ')'
    int 0x10   
    mov ah, 0x0E
    mov al, ' '              ; Space after displaying count
    int 0x10
    call delay               ; Delay between triggers
    jmp trigger_loop

; Simple delay subroutine
delay:
    push cx
    mov cx, 15              ; Outer loop count (adjust to increase/decrease delay)
delay_loop1:
    push cx
    mov cx, 0xFFFF         ; Inner loop count (adjust to increase/decrease delay)
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret


