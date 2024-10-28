[org 100h]

mov bl, [FirstNum]  
mov dl, [SecondNum]   

mov bh, 0            ;for multiplicand    
mov al, bl
sar al, 7                
jns multiPositive 
neg bl                                  
not bh                   

multiPositive: ;for multiplier
 mov al, dl
 sar al, 7              
 jns multipositive
 not dl                 
 add dl, 1              
 not bh                

multipositive: 
 mov cl, 4              
 mov ax, 0             

checkbit:
shr dl,1             
jnc skip                 
add al, bl             

skip:
 shl bl, 1                          
 dec cl                
 jnz checkbit           

 cmp bh, 0x00 
 je termination    
 neg ax   ;2s complement         

termination:
mov ax, 4ch
int 21h

FirstNum: db 13        
SecondNum: db -5        
