[org 0x0100]

mov si, digits
mov di, digits

find_end:
cmp byte [di], -1        ; Checking if the current element is -1
je check_palindrome      ; If yes, jump to palindrome check
inc di                   ; Move to the next element
jmp find_end             ; Repeating until -1 is found

check_palindrome:
    dec di                ; Move DI to the last valid element
    mov cx, di            ; CX will be used as a counter

compare_loop:
    cmp si, di            ; If SI >= DI, we are done
    ja done_comparison
    mov al, [si]          ; Load element at SI
    mov bl, [di]          ; Load element at DI
    cmp al, bl            ; Compare elements
    jne not_palindrome    ; If not equal, it's not a palindrome
    inc si                ; Move SI to the next element
    dec di                ; Move DI to the previous element
    loop compare_loop     ; Repeat until all elements are checked

done_comparison:
    mov bx, 1             ; Set BX to 1 (palindrome)
    jmp end_program

not_palindrome:
    mov bx, 0             ; Set BX to 0 (not a palindrome)

end_program:
mov ax, 4Ch
int 21h

digits: db 1,2,3,2,1,-1