# Template: RISC-V 64 en host Linux con QEMU (flujo minimo, un solo main.s)
# Copia este archivo como Makefile dentro de la leccion.

# ---------------------------------------------------------
# Toolchain
# ---------------------------------------------------------
AS      = riscv64-linux-gnu-as
LD      = riscv64-linux-gnu-ld
QEMU    = qemu-riscv64

# ---------------------------------------------------------
# Paths
# ---------------------------------------------------------
SRC     = main.s
BUILD   = build
OBJ     = $(BUILD)/main.o
BIN     = $(BUILD)/main

# ---------------------------------------------------------
# Flags
# ---------------------------------------------------------
ASFLAGS = -g                    # simbolos de debug
LDFLAGS =

# ---------------------------------------------------------
# Targets
# ---------------------------------------------------------

all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(OBJ): $(SRC) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $<

run: $(BIN)
	$(QEMU) $(BIN)

gdb: $(BIN)
	@echo "Starting QEMU and waiting for GDB on port 1234..."
	$(QEMU) -g 1234 $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make        -> compila el programa RISC-V"
	@echo "  make run    -> ejecuta en QEMU"
	@echo "  make gdb    -> QEMU + espera GDB (VS Code)"
	@echo "  make clean  -> limpia build/"
