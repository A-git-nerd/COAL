[org 100h]

section .data
    myStr db 'I am a student of coal', 0  ; Input string with words
    newline db 13, 10, 0                  ; Newline sequence for printing each word

section .bss
    buffer resb 50                        ; Allocate 50 bytes for token storage

section .text
start:
    ; Initialize SI to point to the start of myStr
    lea si, [myStr]

next_word:
    ; Skip leading spaces
    mov al, [si]
    cmp al, ' '                           ; Check if it's a space
    jne find_word                         ; If not a space, proceed to find a word
    inc si                                ; Skip the space
    jmp next_word                         ; Repeat

find_word:
    ; Initialize DI to point to buffer to store the token
    lea di, [buffer]
    
    ; Copy word into the buffer
copy_word:
    mov al, [si]                          ; Load byte from myStr
    cmp al, ' '                           ; Check if it's a space
    je print_word                         ; If space, print the word
    cmp al, 0                             ; Check for end of string
    je print_word                         ; If end of string, print the last word
    
    stosb                                 ; Store the character in buffer
    inc si                                ; Move to the next character
    jmp copy_word                         ; Repeat

print_word:
    ; Null terminate the token in the buffer
    mov byte [di], 0

    ; Print the word (token) from buffer
    lea dx, [buffer]
    mov ah, 09h
    int 21h

    ; Print newline after each word
    lea dx, [newline]
    mov ah, 09h
    int 21h

    ; Check if the string ended
    cmp al, 0                             ; If null byte, end the program
    je end_program

    inc si                                ; Move to the next character after the space
    jmp next_word                         ; Repeat the process for the next word

end_program:
    ; Exit the program
    mov ax, 4C00h
    int 21h
