.386
.model flat, stdcall
option casemap:none

includelib \masm32\lib\msvcrt.lib
_getch PROTO C :VARARG
printf PROTO C :VARARG

WALL    = 1
BOX     = 2
STORAGE = 4

UP        = 72
DOWN      = 80
LEFT      = 75
RIGHT     = 77
RETURN    = 13
INTERRUPT = 3

LEVELS = 6

.data
newLine BYTE 0ah, 0
clear   BYTE 1bh, "[1;1H", 1bh, "[2J", 0

empty      BYTE "  ", 0
player     BYTE 1bh, "[1;37;40m<>", 1bh, "[0;37;40m", 0
wall       BYTE 1bh, "[0;34;40m██", 1bh, "[0;37;40m", 0
box        BYTE 1bh, "[0;36;40m██", 1bh, "[0;37;40m", 0
storage    BYTE "()", 0
boxStorage BYTE 1bh, "[0;32;40m██", 1bh, "[0;37;40m", 0

logo BYTE 1bh, "[0;36;40m"
     BYTE " ████    █████  ██   ██  █████  ██████    ███   ██   ██", 0ah
     BYTE "██  ██  ██   ██ ██  ██  ██   ██ ██   ██  ██ ██  ███  ██", 0ah
     BYTE "██      ██   ██ ██ ██   ██   ██ ██   ██ ██   ██ ████ ██", 0ah
     BYTE " █████  ██   ██ ████    ██   ██ ██████  ██   ██ ███████", 0ah
     BYTE "     ██ ██   ██ ██████  ██   ██ ██   ██ ███████ ██ ████", 0ah
     BYTE "██   ██ ██   ██ ██ ███  ██   ██ ██   ██ ██   ██ ██  ███", 0ah
     BYTE " █████   █████  ██  ███  █████  ██████  ██   ██ ██   ██", 0ah
     BYTE 1bh, "[0;37;40m", 0

levelNotSelected BYTE 1bh, "[1;37;40mLEVEL %d", 1bh, "[0;37;40m", 0ah, 0
levelSelected    BYTE 1bh, "[1;34;46mLEVEL %d", 1bh, "[0;37;40m", 0ah, 0

solved BYTE 1bh, "[1;32;40mSOLVED!", 1bh, "[0;37;40m", 0

map1 BYTE 0, 0, 1, 1, 1, 1, 1, 0
     BYTE 1, 1, 1, 0, 0, 0, 1, 0
     BYTE 1, 4, 0, 2, 0, 0, 1, 0
     BYTE 1, 1, 1, 0, 2, 4, 1, 0
     BYTE 1, 4, 1, 1, 2, 0, 1, 0
     BYTE 1, 0, 1, 0, 4, 0, 1, 1
     BYTE 1, 2, 0, 6, 2, 2, 4, 1
     BYTE 1, 0, 0, 0, 4, 0, 0, 1
     BYTE 1, 1, 1, 1, 1, 1, 1, 1

map2 BYTE 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 0, 0, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 0, 0, 1, 1, 1, 0, 0, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 0, 0, 1, 0, 0, 2, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
     BYTE 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 4, 4, 1
     BYTE 1, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1
     BYTE 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 4, 4, 1
     BYTE 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1
     BYTE 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

map3 BYTE 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
     BYTE 1, 4, 4, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1
     BYTE 1, 4, 4, 0, 0, 1, 0, 2, 0, 0, 2, 0, 0, 1
     BYTE 1, 4, 4, 0, 0, 1, 2, 1, 1, 1, 1, 0, 0, 1
     BYTE 1, 4, 4, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1
     BYTE 1, 4, 4, 0, 0, 1, 0, 1, 0, 0, 2, 0, 1, 1
     BYTE 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 0, 2, 0, 1
     BYTE 0, 0, 1, 0, 2, 0, 0, 2, 0, 2, 0, 2, 0, 1
     BYTE 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1
     BYTE 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

map4 BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 1, 2, 0, 1, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 2, 1, 0, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 2, 0, 1, 0, 0
     BYTE 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 0, 1, 0, 1, 1, 1
     BYTE 1, 4, 4, 4, 4, 0, 0, 1, 1, 0, 2, 0, 0, 2, 0, 0, 1
     BYTE 1, 1, 4, 4, 4, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 1
     BYTE 1, 4, 4, 4, 4, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
     BYTE 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0

map5 BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 4, 4, 4, 4, 1
     BYTE 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 4, 4, 4, 4, 1
     BYTE 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 2, 0, 2, 0, 0, 0, 4, 4, 4, 4, 1
     BYTE 0, 0, 0, 1, 0, 2, 2, 2, 1, 2, 0, 0, 2, 0, 1, 0, 0, 4, 4, 4, 4, 1
     BYTE 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 4, 4, 4, 4, 1
     BYTE 0, 0, 0, 1, 0, 2, 2, 0, 1, 2, 0, 2, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1
     BYTE 1, 1, 1, 1, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 0, 0, 0, 0, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 0, 2, 2, 1, 2, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
     BYTE 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

map6 BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 2, 1, 1, 0, 0, 1
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 1
     BYTE 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1
     BYTE 1, 4, 4, 4, 4, 0, 0, 1, 1, 0, 2, 0, 0, 2, 1, 1, 1
     BYTE 1, 4, 4, 4, 4, 0, 0, 0, 0, 2, 0, 2, 2, 0, 1, 1, 0
     BYTE 1, 4, 4, 4, 4, 0, 0, 1, 1, 2, 0, 0, 2, 0, 0, 1, 0
     BYTE 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 2, 0, 0, 1, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 2, 0, 0, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0
     BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0

levels DWORD OFFSET map1, 9, 8, 2, 2
       DWORD OFFSET map2, 11, 22, 8, 12
       DWORD OFFSET map3, 10, 14, 4, 7
       DWORD OFFSET map4, 10, 17, 1, 14
       DWORD OFFSET map5, 13, 22, 10, 8
       DWORD OFFSET map6, 13, 17, 7, 14

level   DWORD 1
map     DWORD ?
height  DWORD ?
width_  DWORD ?
playerX DWORD ?
playerY DWORD ?

.code
getSquare proc C x:DWORD, y:DWORD
    mov eax, x
    imul eax, width_
    add eax, y
    add eax, map
    ret
getSquare endp

pushUp proc
    cmp playerX, 1
    jge puDone1
    ret
puDone1:
    mov eax, playerX
    dec eax
    invoke getSquare, eax, playerY
    mov edi, eax
    test BYTE PTR [edi], WALL
    jnz puDone2
    test BYTE PTR [edi], BOX
    jnz puDone2
    dec playerX
    ret
puDone2:
    test BYTE PTR [edi], BOX
    jz puDone3
    cmp playerX, 2
    jl puDone3
    mov eax, playerX
    sub eax, 2
    invoke getSquare, eax, playerY
    mov esi, eax
    test BYTE PTR [esi], WALL
    jnz puDone3
    test BYTE PTR [esi], BOX
    jnz puDone3
    dec playerX
    and BYTE PTR [edi], NOT BOX
    or BYTE PTR [esi], BOX
puDone3:
    ret
pushUp endp

pushDown proc
    mov eax, height
    sub eax, 2
    cmp playerX, eax
    jle pdDone1
    ret
pdDone1:
    mov eax, playerX
    inc eax
    invoke getSquare, eax, playerY
    mov edi, eax
    test BYTE PTR [edi], WALL
    jnz pdDone2
    test BYTE PTR [edi], BOX
    jnz pdDone2
    inc playerX
    ret
pdDone2:
    test BYTE PTR [edi], BOX
    jz pdDone3
    mov eax, height
    sub eax, 3
    cmp playerX, eax
    jg pdDone3
    mov eax, playerX
    add eax, 2
    invoke getSquare, eax, playerY
    mov esi, eax
    test BYTE PTR [esi], WALL
    jnz pdDone3
    test BYTE PTR [esi], BOX
    jnz pdDone3
    inc playerX
    and BYTE PTR [edi], NOT BOX
    or BYTE PTR [esi], BOX
pdDone3:
    ret
pushDown endp

pushLeft proc
    cmp playerY, 1
    jge plDone1
    ret
plDone1:
    mov eax, playerY
    dec eax
    invoke getSquare, playerX, eax
    mov edi, eax
    test BYTE PTR [edi], WALL
    jnz plDone2
    test BYTE PTR [edi], BOX
    jnz plDone2
    dec playerY
    ret
plDone2:
    test BYTE PTR [edi], BOX
    jz plDone3
    cmp playerY, 2
    jl plDone3
    mov eax, playerY
    sub eax, 2
    invoke getSquare, playerX, eax
    mov esi, eax
    test BYTE PTR [esi], WALL
    jnz plDone3
    test BYTE PTR [esi], BOX
    jnz plDone3
    dec playerY
    and BYTE PTR [edi], NOT BOX
    or BYTE PTR [esi], BOX
plDone3:
    ret
pushLeft endp

pushRight proc
    mov eax, width_
    sub eax, 2
    cmp playerY, eax
    jle prDone1
    ret
prDone1:
    mov eax, playerY
    inc eax
    invoke getSquare, playerX, eax
    mov edi, eax
    test BYTE PTR [edi], WALL
    jnz prDone2
    test BYTE PTR [edi], BOX
    jnz prDone2
    inc playerY
    ret
prDone2:
    test BYTE PTR [edi], BOX
    jz prDone3
    mov eax, width_
    sub eax, 3
    cmp playerY, eax
    jg prDone3
    mov eax, playerY
    add eax, 2
    invoke getSquare, playerX, eax
    mov esi, eax
    test BYTE PTR [esi], WALL
    jnz prDone3
    test BYTE PTR [esi], BOX
    jnz prDone3
    inc playerY
    and BYTE PTR [edi], NOT BOX
    or BYTE PTR [esi], BOX
prDone3:
    ret
pushRight endp

isSolved proc
    mov eax, 1
    xor ebx, ebx
isLoop1:
    xor ecx, ecx
isLoop2:
    invoke getSquare, ebx, ecx
    test BYTE PTR [eax], STORAGE
    jz isDone
    test BYTE PTR [eax], BOX
    jnz isDone
    xor eax, eax
    ret
isDone:
    inc ecx
    cmp ecx, width_
    jl isLoop2
    inc ebx
    cmp ebx, height
    jl isLoop1
    ret
isSolved endp

drawWelcome proc
    invoke printf, OFFSET clear
    invoke printf, OFFSET logo
    invoke printf, OFFSET newLine
    mov ecx, 1
dwLoop:
    push ecx
    cmp ecx, level
    jne dwElse
    invoke printf, OFFSET levelSelected
    jmp dwDone
dwElse:
    invoke printf, OFFSET levelNotSelected
dwDone:
    pop ecx
    inc ecx
    cmp ecx, LEVELS
    jle dwLoop
    ret
drawWelcome endp

drawSquare proc C x:DWORD, y:DWORD
    mov eax, playerX
    cmp eax, x
    jne dsDone1
    mov eax, playerY
    cmp eax, y
    jne dsDone1
    invoke printf, OFFSET player
    ret
dsDone1:
    invoke getSquare, x, y
    mov al, BYTE PTR [eax]
    test al, WALL
    jz dsDone2
    invoke printf, OFFSET wall
    ret
dsDone2:
    test al, BOX
    jz dsDone3
    test al, STORAGE
    jz dsDone3
    invoke printf, OFFSET boxStorage
    ret
dsDone3:
    test al, BOX
    jz dsDone4
    invoke printf, OFFSET box
    ret
dsDone4:
    test al, STORAGE
    jz dsDone5
    invoke printf, OFFSET storage
    ret
dsDone5:
    invoke printf, OFFSET empty
    ret
drawSquare endp

drawMap proc
    invoke printf, OFFSET clear
    xor ebx, ebx
dmLoop1:
    xor ecx, ecx
dmLoop2:
    push ebx
    push ecx
    invoke drawSquare, ebx, ecx
    pop ecx
    pop ebx
    inc ecx
    cmp ecx, width_
    jl dmLoop2
    push ebx
    invoke printf, OFFSET newLine
    pop ebx
    inc ebx
    cmp ebx, height
    jl dmLoop1
    ret
drawMap endp

start:
loop1:
    invoke drawWelcome
    invoke _getch
    cmp eax, INTERRUPT
    jne done1
    ret
done1:
    cmp eax, UP
    jne done2
    cmp level, 1
    je done2
    dec level
    jmp loop1
done2:
    cmp eax, DOWN
    jne done3
    cmp level, LEVELS
    je done3
    inc level
    jmp loop1
done3:
    cmp eax, RETURN
    jne done4
    jmp end1
done4:
    jmp loop1
end1:

    mov eax, level
    dec eax
    imul eax, 20
    add eax, OFFSET levels
    mov edx, DWORD PTR [eax]
    mov map, edx
    mov edx, DWORD PTR [eax+4]
    mov height, edx
    mov edx, DWORD PTR [eax+8]
    mov width_, edx
    mov edx, DWORD PTR [eax+12]
    mov playerX, edx
    mov edx, DWORD PTR [eax+16]
    mov playerY, edx

loop2:
    invoke drawMap
    invoke isSolved
    test eax, eax
    jz done5
    invoke printf, OFFSET solved
    ret
done5:
    invoke _getch
    cmp eax, INTERRUPT
    jne done6
    ret
done6:
    cmp eax, UP
    jne done7
    invoke pushUp
    jmp loop2
done7:
    cmp eax, DOWN
    jne done8
    invoke pushDown
    jmp loop2
done8:
    cmp eax, LEFT
    jne done9
    invoke pushLeft
    jmp loop2
done9:
    cmp eax, RIGHT
    jne done10
    invoke pushRight
    jmp loop2
done10:
    jmp loop2
end2:

    ret
end start
