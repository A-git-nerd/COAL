[org 100h]
jmp start

s:db' '

setup:
mov ah,0x13
mov al,1

mov bh,0
mov bl,0x07

mov cx,1
push cs
pop es
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

start:
    call clrSrc  
call setup	

main_loop:
    ; Display prompt to user
    mov ah, 0x0E
    mov al, '>'            ; Display '>'
    int 0x10
    mov al, ' '            ; Display a space
    int 0x10

    ; Read a character from the keyboard
    mov ah, 01h            ; DOS function to check and get a key (with echo)
    int 21h
    mov bl, al             

    ; Check if the character is lowercase (between 'a' and 'z')
    cmp al, 'a'            ; Compare AL with 'a'
    jb skip_conversion     ; If AL < 'a', skip to display character
    cmp al, 'z'            ; Compare AL with 'z'
    ja skip_conversion     ; If AL > 'z', skip to display character

    ; Convert lowercase to uppercase by subtracting 0x20
    sub al, 0x20           ; Convert to uppercase

skip_conversion:
    ; Display the character
    mov ah, 02h            ; DOS function to display character
    mov dl, al             ; Move character to DL for display
    int 21h

    ; Check if the original character was 'qQ' (quit condition)
    cmp bl, 'q'            ; Compare BL with 'q or Q'
    je end_program         ; If equal, exit the program

 
    jmp main_loop

end_program:
    mov ah, 4Ch            
    int 21h
