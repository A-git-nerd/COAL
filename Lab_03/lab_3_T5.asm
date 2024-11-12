[org 0x100]
jmp initialize

initialize: 
    mov si,set1      ; Set1 pointer
    mov di,set2      ; Set2 pointer
    mov bx,0         ; Index for result array


performing_union:
    mov ax,[si]
    mov cx,[di]
    cmp ax,cx
    je equal  ; If (ax == cx)
    cmp ax,cx
    jg greater ; If (ax > cx)
    mov [ResultantArrayOfOperations+bx],ax  ; If (ax < cx)
    add si,2
    add bx,2
    jmp check_union

equal:
    mov [ResultantArrayOfOperations+bx],ax   ; Either [ResultantArrayOfOperations+bx],ax or [ResultantArrayOfOperations+bx],cx since both are equal
    add si,2
    add di,2
    add bx,2
    jmp check_union

greater:
    mov [ResultantArrayOfOperations+bx],cx 
    add di,2
    add bx,2
    jmp check_union

check_union:
    cmp byte[si],0
    je finish_set1_union
    cmp byte[di],0
    je finish_set2_union
    jmp performing_union

finish_set1_union:
    cmp byte[di],0
    je finalize_union
    mov cx,[di]
    mov [ResultantArrayOfOperations+bx],cx
    add bx,2
    add di,2
    jmp finish_set1_union

finish_set2_union:
    cmp byte[si],0
    je finalize_union
    mov ax,[si]
    mov [ResultantArrayOfOperations+bx],ax
    add bx,2
    add si,2
    jmp finish_set2_union

finalize_union:
    mov dx,0xAAAA      ; Signal end of union operation
    mov bx,0
    mov si,set1
    mov di,set2

; Intersection of the sets
find_intersection:
    mov ax,[si]
    mov cx,[di]
    cmp ax,cx
    je save_intersection_value
    jmp skip_intersection

save_intersection_value:
    mov [ResultantArrayOfOperations+bx],ax
    add bx,2

skip_intersection:
    add di,2
    cmp byte[di],0
    je move_to_next_in_set1
    jmp find_intersection

move_to_next_in_set1:
    add si,2
    cmp byte[si],0
    je end_intersection
    mov di,set2       ; Reset di to the start of set2
    jmp find_intersection

end_intersection:
    mov dx,0xBBBB     ; Signal end of intersection
    mov bx,0

; Set subtraction: set2 - set1
begin_subtraction:
    mov si,set2
    mov di,set1

subtract_sets:
    mov ax,[si]
    mov cx,[di]
    cmp ax,cx
    je skip_subtraction_step
    add di,2
    cmp byte[di],0
    je subtract_only_set2
    jmp subtract_sets

subtract_only_set2:
    mov [ResultantArrayOfOperations+bx],ax
    add bx,2
    jmp continue_subtraction

skip_subtraction_step:
    add si,2
    mov di,set1        ; Reset to start of set1 for the next comparison
    cmp byte[si],0
    je end_subtraction
    jmp subtract_sets

continue_subtraction:
    add si,2
    jmp subtract_sets

end_subtraction:
    mov ax,0x4c00      ; End of the program
    int 0x21
	
set1: dw 1,4,5,0
set2: dw 1,2,3,4,6,0
ResultantArrayOfOperations dw 0