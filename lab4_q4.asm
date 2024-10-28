[org 100h]

jmp start

;Data
plainText: dw 0x9999
plainOut: dw 0x0000

CipherKey: dw 0x2694
CipherText: dw 0x0000

; Encryption:
E_odd: dw 0
E_even: dw 0
E: dw 0
D_odd: dw 0
D_even: dw 0
start:
   
    mov ax, [plainText]
    xor ax, [CipherKey]   ; E = PlainText ^ CipherKey
    mov [E], ax           ; Store encrypted value E

   
    mov ax, [E]
    and ax, 0xAAAA        ; Mask to extract odd bits
    mov [E_odd], ax       ; Store odd bits

    mov ax, [E]
    and ax, 0x5555        ; Mask to extract even bits
    mov [E_even], ax      ; Store even bits

    mov ax, [E_odd]
    mov bx, [E_even]
    or ax, bx             ; Combine odd and even bits to get CipherText
    mov [CipherText], ax  ; Store CipherText

    ; Decryption
    mov ax, [CipherText]
    and ax, 0xAAAA        ; Extract odd bits
    mov [D_odd], ax       ; Store odd bits

    mov ax, [CipherText]
    and ax, 0x5555        ; Extract even bits
    mov [D_even], ax      ; Store even bits

    mov ax, [D_odd]
    mov bx, [D_even]
    or ax, bx             ; Combine odd and even bits to get decrypted value D
    xor ax, [CipherKey]   ; Decrypt: D = CipherText ^ CipherKey
    mov [plainOut], ax    ; Store decrypted plaintext

    ; Exit
    mov ax, 4C00h
    int 21h