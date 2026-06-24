# ARM64 + QEMU
# Compila un archivo raiz y deja las dependencias entre archivos a .include.

AS       = aarch64-linux-gnu-as
LD       = aarch64-linux-gnu-ld
QEMU     = qemu-aarch64

BUILD    ?= build
SRC      ?= main.s
ARGS     ?=
GDB_PORT ?= 1234

PROGRAM := $(basename $(notdir $(SRC)))
OBJ     := $(BUILD)/$(PROGRAM).o
TARGET  := $(BUILD)/$(PROGRAM)

ASFLAGS ?= -g -I .
LDFLAGS ?=

.PHONY: all run gdb gdb-vscode clean info

all: $(TARGET)

$(BUILD):
	mkdir -p $(BUILD)

# El archivo indicado en SRC es el punto de entrada del programa.
# Si necesita codigo de otros archivos, usar por ejemplo:
#   .include "01_read_file.s"
$(OBJ): $(SRC) $(wildcard *.s) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $(SRC)

$(TARGET): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $<

run: $(TARGET)
	$(QEMU) $(TARGET) $(ARGS)

gdb: $(TARGET)
	@echo "Starting QEMU and waiting for GDB on port $(GDB_PORT)..."
	$(QEMU) -g $(GDB_PORT) $(TARGET) $(ARGS)

gdb-vscode: $(TARGET)
	@echo "Starting QEMU and waiting for GDB on port $(GDB_PORT)..."
	@$(QEMU) -g $(GDB_PORT) $(TARGET) $(ARGS) & pid=$$!; echo $$pid > $(BUILD)/qemu.pid; sleep 0.2; if kill -0 $$pid 2>/dev/null; then echo "QEMU_GDB_READY"; fi; wait $$pid

clean:
	rm -rf $(BUILD)

info:
	@echo "Uso:"
	@echo "  make                                  -> compila main.s"
	@echo "  make SRC=archivo.s                    -> compila build/archivo"
	@echo "  make SRC=archivo.s run                -> ejecuta con qemu-aarch64"
	@echo "  make SRC=archivo.s ARGS=2 run         -> ejecuta pasando argumento"
	@echo "  make SRC=archivo.s ARGS=2 gdb         -> espera GDB pasando argumento"
	@echo "  make SRC=archivo.s ARGS=2 gdb-vscode  -> espera GDB para VS Code"
	@echo "  make clean                            -> limpia build/"
