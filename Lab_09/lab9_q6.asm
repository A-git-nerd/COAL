[org 0x0100]

jmp start             ; Jump to main program start
counter dw 9          ; Memory location for the counter, initialized to 0

; Clear screen function
clrSrc:
    mov ax, 0xb800         ; Video segment for text mode
    mov es, ax
    mov di, 0              ; Start at top-left corner
    mov ax, 0x0720         ; Space character with white-on-black attribute
    mov cx, 2000           ; Clear 2000 words (80x25 screen)
    rep stosw
    ret

; ISR for INT 0x60
my_isr:
    ; Save registers
    push ax
    push bx
    push cx

    ; Increment the counter
    mov ax, [counter]
    inc ax
    mov [counter], ax

    ; Display counter in hexadecimal (simplified to display 'A' for testing)
    mov bx, ax         ; Copy counter value to BX for display
    call print_hex     ; Call function to print BX in hex

    ; Restore registers
    pop cx
    pop bx
    pop ax

    iret               ; Return from interrupt

; Print hexadecimal value in BX (for testing, just displays 'A')
; Print hexadecimal value in BX
print_hex:
    pusha              ; Save all registers (optional, but safe for testing)
    mov cx, 4          ; 4 hex digits (16 bits, so 4 nibbles)

print_hex_loop:
    rol bx, 4          ; Rotate left by 4 bits to isolate each hex digit
    mov al, bl         ; Move isolated digit into AL
    and al, 0x0F       ; Mask out the lower 4 bits (single hex digit)

    ; Convert to ASCII
    cmp al, 9
    jbe below_ten
    add al, 'A' - 10   ; For A-F hex values
    jmp display_char

below_ten:
    add al, '0'        ; For 0-9 hex values

display_char:
    ; Display character using BIOS teletype service
    mov ah, 0x0E       ; BIOS teletype function
    int 0x10           ; Display the character in AL on the screen

    loop print_hex_loop; Repeat for each hex digit
    popa               ; Restore all registers
    ret


; Main program
start:
    call clrSrc            ; Clear the screen initially

    ; Set up ES to point to the IVT (segment 0x0000)
    cli                    ; Disable interrupts temporarily
    xor ax, ax             ; Set AX to 0
    mov es, ax             ; Set ES to 0, pointing to the IVT

    ; Install custom ISR for INT 0x60
    ;mov ax, cs             ; Load code segment
    mov [es:0x60 * 4 + 2], cs ; Set segment of ISR in IVT
   ; mov ax, my_isr
    mov word [es:0x60 * 4], my_isr      ; Set offset of ISR in IVT

    sti                    ; Re-enable interrupts

    ; Trigger INT 0x60 in a loop to test ISR
    mov cx, 9              ; Set loop count for testing
main_loop:
    int 0x60               ; Trigger INT 0x60, which calls the ISR
    call delay             ; Call a delay to slow down the output
    loop main_loop         ; Repeat 9 times

    ; Exit program
    mov ax, 0x4C00
    int 0x21

; Simple delay function
delay:
    push cx
    mov cx, 3              ; Outer loop count (adjust to increase/decrease delay)
delay_loop1:
    push cx
    mov cx, 0xFFFF         ; Inner loop count (adjust to increase/decrease delay)
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret
