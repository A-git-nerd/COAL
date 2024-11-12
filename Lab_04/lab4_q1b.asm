[org 100h]

start:
    mov ax, 0xABA5        ; Loading the number into AX (1010 1011 1010 0101)

    ; Complement the last 7 bits using XOR
    xor ax, 007Fh         ; 01111111b
                          ; This flips the last 7 bits of AX
  
end:
    mov ax, 4C00h         
    int 21h