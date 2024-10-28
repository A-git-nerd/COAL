[org 100h]
mov ax,0xb800
mov es,ax
mov ds,ax


;----------------12 lines---------------------;
outer:
    mov cx, 13           ; Loop for 13 rows

inner:
    push cx              ; Save outer loop counter

    ; Calculate DI and SI for this row
    add bx, 1
    mov ax, 160
    mul bx               ; DI points to the start of the row
    mov di, ax
    sub ax, 20           ; Shift SI back for copying from the beginning
    mov si, ax
    sub di,2
    sub si,2
    ; Copy 70 words in reverse alignment for each line
    mov cx, 70
l:
    movsw                ; Copy word from DS:SI to ES:DI
    sub di, 4            ; Move DI back for right alignment
    sub si, 4            ; Move SI back to the previous word
    loop l

    ; Clear line with spaces
    sub bx, 1
    mov ax, 160
    mul bx
    mov cx, 10
    mov di, ax
    mov ax, 0x0720       ; Space character with gray color attribute
    rep stosw

    add bx, 1
    pop cx               ; Restore outer loop counter
    loop inner           ; Repeat for each row
mov ax,4ch
int 21h
