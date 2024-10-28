[org 100h]
jmp start

str1: db 'I am a student of coal', 0        ; Input string (null-terminated)
search_char: db 'a'                         ; Character to find (a)
count: db 0                                 ; Counter for occurrences
msg: db 'a:', 0                             ; Message to display
num_str: db '0', 0                          ; To hold the ASCII number of occurrences

start:
    ; Clear the screen
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov cx, 2000
cls:
    mov word [es:di], 0x0720                ; Fill with spaces (attribute 07h)
    add di, 2
    loop cls

    mov ax, 0xb800
    mov es, ax
    mov di, 160                             ; Second line of screen
    mov ah, 0x07                            ; Attribute byte (white text)
    mov si, str1
    mov cx, 22                              ; Length of the string
    cld                                     ; Clear direction flag
next_char:
    lodsb                                   ; Load byte from string into AL
    stosw                                   ; Store AL and AH (character and attribute) in video memory
    loop next_char

    ; Now, find occurrences of 'a' and count them
    mov si, str1                            ; Reload SI to start of the string
    mov cx, 22                              ; Length of the string again
find_a:
    lodsb                                   ; Load next character into AL
    cmp al, [search_char]                   ; Compare AL with 'a'
    jne next_in_search                      ; If not 'a', skip to the next character
    
    ; Increment the occurrence counter if 'a' is found
    inc byte [count]

next_in_search:
    loop find_a                             ; Repeat until the string is done

    ; Convert count to ASCII
    mov al, [count]                         ; Load the count value into AL
    add al, '0'                             ; Convert number to ASCII
    mov [num_str], al                       ; Store the ASCII number in num_str

    ; Display the message and the number of occurrences on the next line
    mov di, 320                             ; Start at the fourth line (160 * 2 = 320)
    mov si, msg                             ; Load message address
print_msg:
    lodsb                                   ; Load byte from message into AL
    cmp al, 0                               ; Check for null terminator
    je print_num                            ; If null terminator, go to print the number
    stosw                                   ; Store the character in video memory
    add di, 2                               ; Move to the next screen position
    jmp print_msg

print_num:
    mov si, num_str                         ; Load the number string address
    lodsb                                   ; Load the ASCII number into AL
    stosw                                   ; Store the number on the screen

    ; End the program
    mov ax, 4C00h
    int 21h
