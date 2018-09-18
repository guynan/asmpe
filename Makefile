
EULER_SRC=euler.asm
EULER_OBJ=euler.o
ASMC=nasm
TARGET_ARCH=elf64
ASM_FLAGS= -f $(TARGET_ARCH)

all: link

$(EULER_OBJ): $(EULER_SRC)
	$(ASMC) $(ASM_FLAGS) -o $(EULER_OBJ) $(EULER_SRC)

%.o: %.asm
	$(ASMC) $(ASM_FLAGS) $< -o $@

%: %.o $(EULER_OBJ)
	gcc $< $(EULER_OBJ) -nostartfiles

#	IF you want named executables...
#	I don't, I reflexivley ./a.[TAB]
#	gcc $< $(EULER_OBJ) -o $@ -nostartfiles

clean:
	$(RM) *.o a.out

