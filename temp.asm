[org 100h]

jmp start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;setup
setup:
mov ax,0xb800
mov es,ax
mov ds,ax
ret

;;;;;;;;;;;;;;;;;;;;;;white_screen
white_screen:
mov cx,2000
white:
mov ax,[ds:di]
and ax,0x0FFF   ;setting ax's 1st 8bits to 0
or ax,0x7000    ;setting ax's 1st 8 bits to 7 (white background)
stosw
loop white
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;border
border:
;1st LINE
mov ah,0x74
mov cx,80
mov di,0
cld
line:
mov al,[ds:di]
stosw
loop line


mov cx,24
mov ah,0x74
mov di,160
cld
loop1:
mov al,[ds:di]
stosw
add di,158
loop loop1


mov cx, 24      
mov di, 318     
mov ah, 0x74 
cld

store_loop:
mov al,[ds:di]
stosw                  
add di, 158        ;already inc di by 2 so, need 158 to add     
loop store_loop        

;last LINE
mov ah,0x74
mov cx,80
mov di,3840
cld
line2:
mov al,[ds:di]
stosw
loop line2

;2nd LINE
mov ah,0xF1
mov cx,78
mov di,162
cld
line3:
mov al,[ds:di]
stosw
loop line3


mov di,322
mov cx,22
cld
loop2:
mov al,[ds:di]
stosw
add di,158
loop loop2

mov di,476
mov cx,22
cld
loop3:
mov al,[ds:di]
stosw
add di,158
loop loop3

;end B LINE

mov di,3682
mov cx,78
cld 
line4:
mov al,[ds:di]
stosw
loop line4

ret

start:
call setup
call white_screen
call border

;end
mov ax,4ch
int 21h