export MSYS2_ARG_CONV_EXCL := *

.PHONY: clean

sokoban.exe: sokoban.obj
	link.exe /SUBSYSTEM:console /LIBPATH:"${LIBPATH}" sokoban.obj

sokoban.obj: sokoban.asm
	ml.exe /c /coff sokoban.asm

clean:
	rm -f *.obj *.exe
