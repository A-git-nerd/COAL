[org 100h]

jmp start

start:
cls:
mov ax,0xb800
mov es,ax
mov di,0
mov ax,0x7720
mov cx,2000
cld
rep stosw

;1st LINE
mov ax,0x7441
mov cx,80
mov di,0
cld
rep stosw


mov cx,24
mov ax,0x7441
mov di,160
cld
loop1:
stosw
add di,158
loop loop1


mov cx, 24      
mov di, 318     
mov ax, 0x7441  
cld

store_loop:
    stosw                  ; Store `AX` at `ES:DI` and increment `DI` by 2
    add di, 158            ; Adjust `DI` to effectively increment by 160
    loop store_loop        ; Repeat until CX = 0

;last LINE
mov ax,0x7441
mov cx,80
mov di,3840
cld
rep stosw

;2nd LINE
mov ax,0xF142
mov cx,78
mov di,162
cld
rep stosw

mov di,322
mov cx,22
cld
loop2:
stosw
add di,158
loop loop2

mov di,476
mov cx,22
cld
loop3:
stosw
add di,158
loop loop3

;end B LINE
mov di,3682
mov cx,78
cld 
rep stosw

;end
mov ax,4ch
int 21h