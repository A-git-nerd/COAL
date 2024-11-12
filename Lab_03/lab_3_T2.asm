[org 100h]

mov ax, [num]         ; Load the number into AX
cmp ax, 2             ; Compare AX with 2
jl not_prime          ; If number is less than 2, it's not prime

mov cx, 2             ; Start divisor from 2
mov bx, ax            ; BX holds the original number

check_div:
cmp cx, bx            ; Checking if divisor equals the number itself
jge prime             ; If divisor reaches the number, it's prime

mov dx, 0             ; Clear DX before division
mov ax, bx            ; Reload the number into AX
div cx                ; Divide the number by divisor in CX

cmp dx, 0             ; Checking if remainder is zero (divisible)
je not_prime          ; If remainder is zero, the number is not prime

inc cx                ; Increment divisor
jmp check_div         ; Loop back to check next divisor

not_prime:
mov al, 0             ; Number is not prime, set AL to 0
jmp last              ; Jump to program termination

prime:
mov al, 1             ; Number is prime, set AL to 1

last:
mov ah, 4Ch           ; Terminate program
int 21h               

num: dw 7             