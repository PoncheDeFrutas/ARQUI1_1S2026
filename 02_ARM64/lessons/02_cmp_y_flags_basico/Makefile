# Leccion 02 - CMP y flags basico
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld
QEMU    = qemu-aarch64

SRC     = main.s
BUILD   = build
OBJ     = $(BUILD)/main.o
BIN     = $(BUILD)/main

ASFLAGS = -g

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(OBJ): $(SRC) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN): $(OBJ)
	$(LD) -o $@ $<

run: $(BIN)
	$(QEMU) $(BIN)

gdb: $(BIN)
	$(QEMU) -g 1234 $(BIN)

clean:
	rm -rf $(BUILD)
