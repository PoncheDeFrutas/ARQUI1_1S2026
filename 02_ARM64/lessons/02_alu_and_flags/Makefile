# ==========================================================
# Leccion 02 - ALU y banderas en ARM64 (Linux)
# Build:  as (AArch64) + ld (AArch64)
# Run  :  qemu-aarch64
# Debug:  qemu-aarch64 gdbstub
# ==========================================================

AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld
QEMU    = qemu-aarch64

BUILD   = build
TARGET  = $(BUILD)/main

MAIN_SRC = main.s
AUX_SRCS = $(filter-out $(MAIN_SRC), $(wildcard *.s))
SRCS     = $(MAIN_SRC) $(AUX_SRCS)
OBJS     = $(patsubst %.s,$(BUILD)/%.o,$(SRCS))

ASFLAGS = -g
LDFLAGS =

all: $(TARGET)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.o: %.s | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

run: $(TARGET)
	$(QEMU) $(TARGET)

gdb: $(TARGET)
	@echo "Starting QEMU and waiting for GDB on port 1234..."
	$(QEMU) -g 1234 $(TARGET)

clean:
	rm -rf $(BUILD)

info:
	@echo "Targets disponibles:"
	@echo "  make        -> compila el programa"
	@echo "  make run    -> ejecuta en QEMU"
	@echo "  make gdb    -> QEMU + espera GDB (VS Code)"
	@echo "  make clean  -> limpia build/"
