SOURCES = $(wildcard *.asm)
OBJECTS = $(SOURCES:.asm=.o)

BIN = mochiwm

LDFLAGS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lxcb -lxcb-keysyms -lc

all: $(BIN)

debug-build: $(BIN)

$(BIN): $(OBJECTS)
	ld -o $@ $(OBJECTS) $(LDFLAGS)

%.o: %.asm
	fasm $< $@

clean:
	rm -f *.o $(BIN)

run: $(BIN)
	./$(BIN)

.PHONY: all clean run debug
