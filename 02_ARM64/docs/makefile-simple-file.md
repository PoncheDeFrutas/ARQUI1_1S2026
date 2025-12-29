# Makefile – Lección 00 (flujo simple, un solo archivo)

Documento de referencia rápida para el Makefile minimalista de `lessons/00_hello_world`. Úsalo cuando la lección tenga **solo un archivo fuente (`main.s`)** y quieras un pipeline explícito y corto.

## Flujo y objetivos
- Ensambla `main.s` → `build/main.o` con símbolos de depuración (`-g`).
- Enlaza el objeto a `build/main`.
- Ejecuta en QEMU (`make run`) o abre el stub de GDB (`make gdb`) para depurar desde VS Code.

## Comandos disponibles
- `make` : compila y enlaza.
- `make run` : ejecuta el binario en QEMU.
- `make gdb` : arranca QEMU en modo depuración (GDB en `localhost:1234`).
- `make clean` : limpia `build/`.
- `make info` : muestra la ayuda breve.

## Código completo del Makefile

```makefile
# ==========================================================
# Lección 00 – Hello World en ARM64 (Linux)
# Build:  as (AArch64) + ld (AArch64)
# Run  :  qemu-aarch64
# Debug:  qemu-aarch64 gdbstub
# ==========================================================

# ---------------------------------------------------------
# Toolchain
# ---------------------------------------------------------
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld
QEMU    = qemu-aarch64

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
ASFLAGS = -g                 			# símbolos de debug
LDFLAGS =

# ---------------------------------------------------------
# Targets
# ---------------------------------------------------------

# Compilación por defecto
all: $(BIN)

# Crear carpeta build si no existe
$(BUILD):
	mkdir -p $(BUILD)

# Ensamblar
$(OBJ): $(SRC) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

# Enlazar
$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $<

# Ejecutar normalmente en QEMU
run: $(BIN)
	$(QEMU) $(BIN)

# ---------------------------------------------------------
# Debug con QEMU + GDB remoto
# ---------------------------------------------------------
gdb: $(BIN)
	@echo "Starting QEMU and waiting for GDB on port 1234..."
	$(QEMU) -g 1234 $(BIN)

# ---------------------------------------------------------
# Limpieza
# ---------------------------------------------------------
clean:
	rm -rf $(BUILD)

# ---------------------------------------------------------
# Utilidades
# ---------------------------------------------------------
info:
	@echo "Targets disponibles:"
	@echo "  make        -> compila el programa"
	@echo "  make run    -> ejecuta en QEMU"
	@echo "  make gdb    -> QEMU + espera GDB (VS Code)"
	@echo "  make clean  -> limpia build/"
```

