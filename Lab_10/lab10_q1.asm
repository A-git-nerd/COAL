[org 100h]
jmp start

; Store old keyboard ISR address here
oldkb: dd 0             
; Prompt message        
prompt: db "Enter your name: ", 0  
; Buffer to store the name
name: times 32 db 0        
; Size of the entered name     
size: dw 0                      

myKbISR:
    push ax
    push bx
    push cx
    push dx
    push es
    push ds
    
    mov ax, 0xb800              
    mov es, ax
    mov ax, cs
    mov ds, ax

; Read scan code from keyboard port
    in al, 0x60        
; Check if left shift key is released (0xAA)	
    cmp al, 0xAA      
; If not, jump to shiftPress	
    jne shiftPress    
 ; If left shift is released, clear the screen	
    call clearScrn  
 ; Exit ISR	
    jmp endISR                 

shiftPress:
; Check if left shift key is pressed (0x2A)
    cmp al, 0x2A          
 ; If not, exit ISR	
    jne endISR                 
  ; Clear screen before displaying name
    call clearScrn            
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 7
    mov dx, 0
    mov cx, [size]             
    push cs
    pop es
    mov bp, name                
    int 0x10

endISR:
    pop ds
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
	; Jump to original keyboard ISR
    jmp far [cs:oldkb]          

clearScrn:
    push es
    push cx
    push ax
    push di
    mov ax, 0xb800             
    mov es, ax
    mov di, 0
    mov ax, 0x0720             
    mov cx, 2000               
    rep stosw
    pop di
    pop ax
    pop cx
    pop es
    ret

getInput:
    push bp
    mov bp, sp
    pusha

    call clearScrn

    ; Display the prompt "Enter your name: "
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 7
    mov dx, 0
    mov cx, 16                
    push cs
    pop es
    mov bp, prompt
    int 0x10

    mov si, name
    mov word [size], 0
    mov cx, 32
inputLoop:
    mov ah, 0x00
    int 0x16                 
    cmp al, 13               
    je endInput

    mov [cs:si], al          
    inc si
    inc word [size]          
    mov ah, 0x0e
    int 0x10                 
    loop inputLoop

endInput:
    popa
    pop bp
    ret

start:
    call getInput              

    xor ax, ax
    mov es, ax
    mov ax, [es:9*4]           
    mov [oldkb], ax
    mov ax, [es:9*4+2]
    mov [oldkb+2], ax

    cli                        
    mov word [es:9*4], myKbISR 
    mov word [es:9*4+2], cs
    sti                        

 ; Re-enable interrupts
    ; TSR - Terminate and Stay Resident
    mov dx, start
    add dx, 15
    mov cl, 4
    shr dx, cl
    mov ax, 0x3100
    int 0x21
