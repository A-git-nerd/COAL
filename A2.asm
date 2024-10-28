[org 0x100]

jmp start
numbers:db 0x01,0x03,0x07 ;byte numbers
size:db 3 ;size
count:db 0 ;for counting number of 1
iterations:db 0 ;for iterating 8 bits number
result: db 0x00,0x00,0x00,0x00,0x00 ;to store even parity number at starting

start:
mov si,0 ;for taking numbers

taking_number:
cmp si,[size] ;condition to terminate program from taking numbers 
je end

mov al,[numbers+si] ;loading number

counting: ;counting num of 1
cmp si,[size] ;condition to terminate program from taking numbers 
je end

cmp byte [iterations],8 ;terminate loop after 8 bit
je checking_counts

shr al,1 ;taking lsb bit
jc carryFound

inc byte [iterations] ;only increament iterations
jmp counting

carryFound: ;increament count and iterations
inc byte [count]
inc byte [iterations]
jmp counting

checking_counts: ;checking_counts by shr if CF=1 its odd then need to remove it
mov al,[count]
shr al,1
jc oddParity ;removing that number
inc si
mov byte [iterations],0
mov byte [count],0
mov ax,0
jmp taking_number

oddParity:  ;removing the oddParity number
mov byte [numbers+si],0
inc si
mov byte [iterations],0
mov byte [count],0
mov ax,0
jmp taking_number


end:
mov si,0
mov di,0
writing_numbers_in_result: ;writing even parity numbers in result
cmp si,[size]
je terminate

cmp byte [numbers+si],0x00
jne write ;if number is non zero then need to write
inc si ;if number is zero then increament si only
jmp writing_numbers_in_result

write:
mov ax,[numbers+si]
mov [result+di],ax
inc di  ;if number is zero then need to increament si and di 
inc si
jmp writing_numbers_in_result

terminate:
mov ax,0x4c00
int 0x21