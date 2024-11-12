[org 0x0100]
jmp start

message: db 'Non-Maskable Interrupt Occurred!', 0

; Custom NMI (INT 2) handler
custom_nmi_handler:
    push ax
    push bx
    push cx
    push dx
    push bp
    push si
    push di

    ; Display message to notify the user of an NMI
    mov ah, 0x09             ; DOS interrupt to display string
    mov dx, message          ; Load address of message
    int 0x21                 ; Call DOS interrupt to display message

    ; Perform additional NMI handling here if necessary

    ; Restore registers and return
    pop di
    pop si
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    iret                     ; Return from interrupt

start:
    ; Install custom INT 2 handler
    cli                      ; Disable interrupts temporarily
    mov ax, seg custom_nmi_handler
    mov word [2 * 4 + 2], ax ; Set segment for INT 2 handler
    mov ax, offset custom_nmi_handler
    mov word [2 * 4], ax     ; Set offset for INT 2 handler
    sti                      ; Re-enable interrupts

    ; Simulate a delay or normal program flow
delay_loop:
    mov cx, 0FFFFh           ; Large delay
waitt:
    loop waitt

    ; Program exit
    mov ax, 4C00h
    int 21h