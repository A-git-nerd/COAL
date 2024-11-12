[org 100h]

jmp start

str1: db 'I am a student of coal', 0  
row: db 1                            ; Start at row 1 ;use to increament lines

start:

; Clear screen
clr:
push ax
push es
push di
push cx
mov ax,0xB800
mov es,ax
mov di,0
mov cx,2000
cls:
mov word[es:di],0x0720               
add di,2
loop cls
pop cx
pop di
pop es
pop ax




push ax
push es
push di
push ax


mov ax, 0xb800
mov es, ax
mov di, 0                          

; Print each word from the string
mov si, str1                       ; SI points to the start of the input string
mov ah, 0x07                       ; Attribute byte for white text
cld                                ; Clear direction flag to move forward through the string

print_loop:
lodsb                              ; Load the next character from the string into AL
cmp al, 0                          ; Check if we've reached the null terminator
je done                            ; If null terminator, we're done

cmp al, ' '                        ; Check if the current character is a space
je new_line                        ; If it's a space, move to the next line

; Store the character and attribute in video memory
mov [es:di], al                    ; Store the character in video memory
mov [es:di+1], ah                  ; Store the attribute (white text)
add di, 2                          ; Move to the next screen position
jmp print_loop                     ; Repeat for the next character

new_line:

    ;used to increament di using row , reg are preserved
push ax
push bx
mov di,0                           ; Reset di to start at the beginning of the new line
mov ax, [row]                      ; Get the current row
mov bx, 160                        ; Each row in video memory is 160 bytes
mul bx                             ; Calculate the starting position for the new line
add di, ax                         ; Adjust DI to point to the new line
inc byte [row]                     ; Increment the row number
pop bx
pop ax
jmp print_loop                     ; Continue printing the next word


pop ax
pop es
pop di
pop ax

done:
; End the program
mov ax, 4C00h
int 21h
