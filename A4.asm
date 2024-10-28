[org 0x100]

jmp start
multiplicand: db -1       ;bl ;8bit number
multiplier:   db 8        ;dl  ;8bit number
result:      dw 0              ;16bit number

start:
mov bl, [multiplicand]  
mov dl, [multiplier]   

;for multiplicand
mov ch, 0                ;making ch=0x00
mov al, bl               ;moving multiplicand in al to chec its sign
sar al, 7                ;taking sign
jns multiplicand_positive  ;if sf=0 its positive
not ch          ;else make bh=0x11         

not bl                            ;taking 2's complement of multiplicand if sf=1      
add bl,1

multiplicand_positive: ;for multiplier
 mov al, dl   ;loading multiplier in al
 sar al, 7    ;checking sign          
 jns multiplier_positive ;if sf=0 then multiplier is positive
 not dl                 ;else taking 2's complement
 add dl, 1              
 not ch                ;taking not of bh 

multiplier_positive: 
 mov cl, 8              ;count , multiplier is 4 bit number
 mov ax, 0             

;multiplication logic that we learn in class
checkbit:
shr dx,1             
jnc skip                 
add ax, bx             

skip:
 shl bx, 1                          
 dec cl                
 jnz checkbit           

 cmp ch, 0x00 ;if ch=0x00 result must be in positive e.g(+ve)(+ve) or (-ve)(-ve)
 je termination    
 not ax            ;else ch=0x11 need to taking 2's complement of result cuz (+ve)(-ve) or (-ve)(+ve)
add ax,1

termination:
mov [result], ax  ;moving ax into result         

mov ax, 0x4c00
int 0x21