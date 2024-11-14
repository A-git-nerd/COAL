[org 100h]
jmp start

oldkb: dd 0                   
buffer: times 4000 db 0                    

; Save Screen Routine
saveScreen:
    pusha
    mov ax, 0xb800             
    mov ds, ax                 
    mov ax, cs
    mov es, ax                 
    mov di, buffer             
    mov si, 0                  
    mov cx, 2000               

    cld                        
    rep movsw                  
    popa
    ret

; Restore Screen Routine
restoreScreen:
    pusha
    mov ax, 0xb800            
    mov es, ax                
    mov ax, cs
    mov ds, ax                
    mov si, buffer            
    mov di, 0                 
    mov cx, 2000              

    cld                       
    rep movsw                 
    popa
    ret

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

    in al, 0x60    
    cmp al, 0x30   
    je BPRESSED    
    cmp al, 0xB0   
    je BRELEASED   
	
    jmp endISR     

BPRESSED:
                   
 call saveScreen   
    call clearScrn 
                   
    jmp endISR     

BRELEASED:
                   
 call restoreScreen
                   
    jmp endISR     

endISR:
    pop ds
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    jmp far [cs:oldkb]         

start:
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

    mov dx, start
    add dx, 15
    mov cl, 4
    shr dx, cl
    mov ax, 0x3100
    int 0x21
