[org 100h]

jmp Print

R: db 1, 5, 7, 8, 2, -1   ; Array of row values (8-bit)
C: db 0, 0, 1, 3, 2, -1   ; Array of column values (8-bit)

Print:
    mov ax, 0xb800         ; Set video memory segment
    mov es, ax
    mov di, 0              ; Initialize DI to top left of video memory
    mov si, 0              ; Initialize SI to 0 (index for R and C)
    mov ah, 0x07           ; Attribute for white text on black background

LesGo:
    mov al, [R + si]       ; Load 8-bit value from R into AL
    cmp al, -1             ; Check for end of array (-1 marks end)
    je end                 ; Jump to end if reached the end of array

    push ax                ; Push R (Row) value on stack (must be word-aligned)
    
    mov al, [C + si]       ; Load 8-bit value from C into AL
    mov ah, 0              ; Zero out AH to make it a 16-bit value in AX
    push ax                ; Push C (Column) value on stack

    add si, 1              ; Move to the next element in arrays

    call Cal               ; Call subroutine to calculate video memory offset

    pop word di            ; Get the calculated DI (destination index)
    mov byte [es:di], 0x41 ; Write 'A' character at the calculated position
    mov byte [es:di+1], 0x07 ; Set attribute (white on black)

    add di, 2              ; Move to the next character position in video memory

    jmp LesGo              ; Repeat for the next character

Cal:
    push bp                ; Save BP
    mov bp, sp             ; Set BP to point to the current stack frame

    mov ax, [bp + 4]       ; C (Column) value
    mov bx, [bp + 6]       ; R (Row) value

    ; Calculate video memory offset:
    ; Each row in text mode consists of 80 columns.
    ; Each character takes 2 bytes in video memory (1 byte for character, 1 for attribute).
    ; Formula: offset = (row * 80 + column) * 2

    shl bx, 1              ; Multiply R (Row) by 2 (word size in video memory)
    mov di, 80             ; 80 columns per row
    mul di                 ; Multiply Row * 80 -> result in AX (DX:AX)
    add ax, [bp + 4]       ; Add the column value
    shl ax, 1              ; Multiply by 2 to get byte offset
    push ax                ; Push the result (video memory offset)

    pop bp                 ; Restore BP
    ret 4                  ; Return and clean up 4 bytes (R and C pushed)

end:
    mov ax, 4c00h          ; Terminate the program
    int 21h
