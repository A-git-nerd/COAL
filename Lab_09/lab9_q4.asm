[org 0x0100]

jmp start 

delay:
    push cx
    mov cx, 80              ; Outer loop count (adjust to increase/decrease delay)
delay_loop1:
    push cx
    mov cx, 0xFFFF         ; Inner loop count (adjust to increase/decrease delay)
delay_loop2:
    loop delay_loop2
    pop cx
    loop delay_loop1
    pop cx
    ret


;;;;Function
clear_screen:
;flag pushed to check interrupt flag
pushf
pop ax
and ax,0x0300
jz interruptCalled

    cld                    ; Clear the direction flag
    ; Set video segment and attributes for clearing screen
    mov ax, 0xB800         
    mov es, ax
    mov di, 0              
    mov ax, 0x0720         
    mov cx, 2000           
    rep stosw              

    ; Detect whether near or far call
	
	;if it was near call stack has ret and garbage(not required)
	;if it was far call stack has ret and cs
	
	;if near call
	;ax will get ret
	;dx will get either cs or garbage if dx==cs then it was far call else near call
    pop ax                 
    pop dx                
    mov bx, cs             
    cmp dx, bx             
    jne near_return        

far_return:
    push dx                ; Push the segment back for far return
    push ax                ; Push the offset back for far return
    retf                   ; Far return

near_return:
    push ax                ; Push offset back onto the stack for near return
    ret                    ; Near return

interruptCalled:
iret
; Main Program
start:

    cli                    ; Disable interrupts temporarily
    xor ax, ax             ; Set AX to 0
    mov es, ax             ; Set ES to 0, pointing to the IVT

    ; Install our screen-clear function at INT 0x80
    mov word [es:0x80 * 4 + 2], cs ; Set segment of ISR in IVT
    mov word [es:0x80 * 4], clear_screen     ; Set offset in the IVT

    sti                    ; Re-enable interrupts
    
	call clear_screen  ;near call 

    call 0x19F5:clear_screen     ;far call  
 
    int 0x80               
	
    mov ax, 0x4C00
    int 0x21
