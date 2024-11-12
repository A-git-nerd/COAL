[org 0x0100]

jmp START

carry : DW 240 DUP(0) 

; Delay routine to make the scrolling effect visible
DELAY:
    push cx
    mov cx, 15         
delay_loop1:
    push cx
    mov cx, 0xFFFF    ; Inner loop for delay
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret

; Store the current line to the CARRY buffer
STORELINE:
    push bp
    mov bp, sp

    push ax
    push cx
    push ds
    push si
    push es
    push di

    ; Set segment for screen memory
    mov ax, ds
    mov es, ax
    mov ax, 0xB800
    mov ds, ax

    ; Load source and destination pointers
    mov si, [bp+4]    ; Source: Line in screen memory 
    mov di, carry     ; Destination: CARRY buffer
    mov cx, 240       ; Copy 240 bytes (one line)

    cld               ; Clearing direction flag for forward copying
    rep movsw         ; Copy from SI (screen) to DI (carry buffer)

    ; Restore registers and stack
    pop di
    pop es
    pop si
    pop ds
    pop cx
    pop ax
    pop bp

    ret 2            

; Scroll the screen down by 3 rows
SCROLLDOWN:
    push ax
    push cx
    push ds
    push si
    push es
    push di

    ; Store the last line (row 24) before scrolling down
    mov ax, 3520      ; Row 24 (the last row)
    push ax
    call STORELINE

    ; Set segment for screen memory
    mov ax, 0xB800
    mov es, ax
    push ds
    mov ds, ax

    ; Scroll down by copying the screen upwards
    mov si, 3518      ; Start from the last row minus 3 rows
    mov di, 3998      ; Move up 3 rows
    mov cx, 1760      ; Number of bytes to move (80 columns x 22 rows)

    std               ; Set direction flag for backward copying
    rep movsw         ; Copy screen data upwards

    ; Restore the last line from CARRY buffer to the first row
    pop ds
    mov si, carry     ; Load the last line from carry buffer
    mov di, 0         ; Restore to row 0
    mov cx, 240       ; Copy 240 bytes (one line)

    cld               ; Clear direction flag for forward copying
    rep movsw         ; Copy from carry buffer to screen

    ; Restore registers
    pop di
    pop es
    pop si
    pop ds
    pop cx
    pop ax

    ret

; Scroll the screen up by 3 rows
SCROLLUP:
    push ax
    push cx
    push ds
    push si
    push es
    push di

    ; Store the first line (row 0) before scrolling up
    mov ax, 0         ; Row 0 (the first row)
    push ax
    call STORELINE

    ; Set segment for screen memory
    mov ax, 0xB800
    mov es, ax
    push ds
    mov ds, ax

    ; Scroll up by copying the screen downwards
    mov si, 480       ; Start from the second row (row 3)
    mov di, 0         ; Move to the first row
    mov cx, 1760      ; Number of bytes to move (80 columns x 22 rows)

    cld               ; Clear direction flag for forward copying
    rep movsw         ; Copy screen data downwards

    ; Restore the first line from CARRY buffer to the last row
    pop ds
    mov si, carry     ; Load the first line from carry buffer
    mov di, 3520      ; Restore to row 24 (the last row)
    mov cx, 240       ; Copy 240 bytes (one line)

    cld               ; Clear direction flag for forward copying
    rep movsw         ; Copy from carry buffer to screen

    ; Restore registers
    pop di
    pop es
    pop si
    pop ds
    pop cx
    pop ax

    ret

; Infinite loop to continuously scroll the screen up and down
START:
L3:
; Adding delay for visibility
    call DELAY
    call SCROLLDOWN    ; Scroll down by 3 rows
; Adding delay for visibility   
   call DELAY      
    call SCROLLUP      ; Scroll up by 3 rows
	; Adding delay for visibility
	call DELAY
    jmp L3             ; Loop indefinitely

    ; End the program
    mov ax, 0x4C00
    int 0x21
