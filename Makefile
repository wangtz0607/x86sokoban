export MSYS2_ARG_CONV_EXCL := *

.PHONY: clean

sokoban.exe: sokoban.obj
	link /SUBSYSTEM:console /LIBPATH:"${LIBPATH}" sokoban.obj

sokoban.obj: sokoban.asm
	ml /c /coff sokoban.asm

clean:
	rm -f *.obj *.exe
