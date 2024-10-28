[org 100h]
jmp start

setup:
mov bx,158              ;1st line's last index
mov cx,24               ;Total rows
ret

rightAllignment:
pusha  ;pushed all general registers
mov ax,0xb800
mov ds,ax
mov es,ax
;bx ->158
xor cx,cx 
std ;reverse
mov di,bx
mov ax,0x0720
mov dx,80 ;total columns in one rows
spacing:
scasw   ;cmp [es:di],ax
jnz Character_has_found
add cx,1
dec dx
jnz spacing
jmp notFound


Character_has_found:
add di,2  ;now reached 1st space
mov si,di
mov di,bx
mov dx,cx ;spaces
mov cx,80
sub cx,dx ;non char

rep movsw

mov cx,dx
rep stosw 

notFound:
popa
ret

start:
call setup

till_total_rows:
call rightAllignment
add bx,160
loop till_total_rows

;end
mov ax,4ch
int 21h