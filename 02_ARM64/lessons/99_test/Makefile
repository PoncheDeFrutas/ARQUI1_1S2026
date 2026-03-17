# Template: ARM64 nativo con X11 para host ARM64

# ---------------------------------------------------------
# Toolchain (host ARM64)
# ---------------------------------------------------------
AS      = as
CC      = gcc

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
ASFLAGS = -g
LDFLAGS = -no-pie
LDLIBS  = -lX11

# ---------------------------------------------------------
# Targets
# ---------------------------------------------------------
all: $(BIN)

$(BUILD):
	mkdir -p $(BUILD)

$(OBJ): $(SRC) | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS)

run: $(BIN)
	$(BIN)

gdb: $(BIN)
	gdb $(BIN)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets:"
	@echo "  make        -> compila el binario"
	@echo "  make run    -> abre ventana X11"
	@echo "  make gdb    -> depura con gdb"
	@echo "  make clean  -> limpia build/"
	@echo ""
	@echo "Dependencias:"
	@echo "  sudo apt install -y libx11-dev"
