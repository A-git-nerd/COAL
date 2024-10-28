[org 100h]

mov al,0x11
mov dl,0x2

div dl  ;al will q and ah will be r

mov ax,4ch
int 21h