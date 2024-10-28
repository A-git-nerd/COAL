[org 0x100]
jmp start
mainArray: dw -3,1,2,5,6,8 ;main array
subArray:dw -1,2,5,6 ;sub array
size_for_main_array: dw 10 ;size in terms of word 
size_for_sub_array: dw 6 ; size in terms of word

index:dw -1 ;index assume notFound at start
mov si,0 ;for sub array
mov di,0 ;for main array

start:

outerLoop:
mov ax,[size_for_main_array] ;checking if size_for_main_array is full , it should go at end
cmp ax,di
je OuterLoopEnds

mov ax,[size_for_sub_array] ;checking if size_for_sub_array is full , it should go at end
cmp ax,si
je OuterLoopEnds


mov ax,[subArray + si]
cmp ax,[mainArray + di]
je found ;comparing


mov word si,0 ;if not equal then di+=2 but si=0 and index=-1 
inc di
inc di
mov word [index],-1
jmp outerLoop

found:
cmp word si,0  ;if found then checking its 1st index want to store index
je equaltoOne
inc di ;if it was not 1st index of subArray then just di+=2 and si+=2
inc di
inc si
inc si
jmp outerLoop

equaltoOne: ;storing 1st index of sub array in index
mov ax,[mainArray+di]
mov [index],ax
inc di ;if it was not 1st index of subArray then just di+=2 and si+=2
inc di
inc si
inc si
jmp outerLoop


notFound: ;if not found then set index to -1
mov word [index],-1
jmp end

OuterLoopEnds:
mov ax,[size_for_sub_array]
cmp ax,si
jne notFound
mov dx,[index] ;storing index in dx if found
jmp end

end:
mov ax,0x4c00
int 0x21