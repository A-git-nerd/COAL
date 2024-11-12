[org 0x0100]

mov si, 2                        ; Start from the second element (index 1, so 2 bytes)
outerloop:
    cmp si, [size]                ; Compare current index with size
    jge done                      ; If si >= size, sorting is done

    mov ax, [arr + si]            ; Load the current element to be inserted (key)
    mov [key], ax                 ; Store the key in the 'key' variable
    mov di, si                    ; Initialize di to the current index
    sub di, 2                     ; Move back to the previous element

innerloop:
    cmp di, 0                     ; If di < 0, break out of the inner loop
    jl outofinnerloop

    mov ax, [arr + di]            ; Load the element at arr[di]
    cmp ax, [key]                 ; Compare arr[di] with key
    jle outofinnerloop            ; If arr[di] <= key, break out of inner loop

    mov [arr + di + 2], ax        ; Shift arr[di] to the right
    sub di, 2                     ; Move to the previous element
    jmp innerloop                 ; Repeat inner loop

outofinnerloop:
    mov ax, [key]                 ; Load the key
    mov [arr + di + 2], ax        ; Place the key in its correct position

    add si, 2                     ; Move to the next element in the outer loop
    jmp outerloop                 ; Repeat outer loop

done:
    mov ax, 0x4c00                ; Exit program
    int 0x21

;declaration
arr:  dw 5, 3, 8, 6, 2, 7, 4, 10, 1, 9  ; The array to be sorted
size: dw 20                             ; Size of the array (20 bytes = 10 elements * 2 bytes each)
key:  dw 0                               ; Temporary storage for the key

