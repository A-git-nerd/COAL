; size=5
; size/2=2
; while(size>0){
; if(head!=tail){
; return -1;
; }
; head++;
; tail--;
; size--;
; }
; }

; return 1;

[org 100h]
mov dx,0
mov cx,[size]
mov bx ,[tail]

Finding_Size:
mov ax,[array+bx] 
cmp ax,-1
je fixing_size_its_goes_to_neg_one
inc cx
inc bx
inc bx
jmp Finding_Size

fixing_size_its_goes_to_neg_one:
dec bx
dec bx
jmp num_of_iteratons_need

num_of_iteratons_need:
mov [tail],bx
mov [size],cx
mov bx,2
jmp divide



divide:
sub cx,2
inc dx
cmp cx,1
jbe size_found
jmp divide

size_found:
mov si,[head]
mov di,[tail]
mov ax,[array+si]
mov bx,[array+di]
cmp ax,bx
jne not_found
inc word [head]
inc word [head]
dec word [tail]
dec word [tail]
dec dx
cmp dx,0
je found
jmp size_found



found:
mov dx,1
jmp end

not_found:
mov dx,0
end:
mov ax,4ch
int 21h

array:dw 1,2,3,62,1,-1
size:dw 0
head:dw 0
tail: dw 0