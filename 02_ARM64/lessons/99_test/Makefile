# ==========================================================
# Makefile – Programas AArch64 (ARM64) en Linux
#
# Este Makefile permite:
#  - Ensamblar uno o más archivos AArch64 (.s)
#  - Enlazarlos en un único ejecutable ELF ARM64
#  - Ejecutar el binario en un host x86 y x64 usando QEMU (user-mode)
#  - Depurar el programa mediante GDB remoto desde VS Code
#
# Convenciones del proyecto:
#  - El archivo principal SIEMPRE se llama: main.s
#  - Archivos auxiliares: *.s (mismo directorio)
#  - El ejecutable final SIEMPRE se llama: build/main
# ==========================================================


# ----------------------------------------------------------
# Toolchain (compilación cruzada AArch64)
# ----------------------------------------------------------
# Ensamblador ARM64
AS      = aarch64-linux-gnu-as

# Enlazador ARM64
LD      = aarch64-linux-gnu-ld

# Emulador ARM64 en modo usuario (Linux)
QEMU    = qemu-aarch64


# ----------------------------------------------------------
# Rutas y nombres de salida
# ----------------------------------------------------------
# Directorio de salida para objetos y binario final
BUILD   = build

# Ejecutable final (ELF ARM64)
TARGET  = $(BUILD)/main


# ----------------------------------------------------------
# Fuentes
# ----------------------------------------------------------
# Archivo principal (punto de entrada _start)
MAIN_SRC = main.s

# Archivos auxiliares (si existen)
# Se incluyen todos los .s excepto main.s
AUX_SRCS = $(filter-out $(MAIN_SRC), $(wildcard *.s))

# Lista total de fuentes
SRCS = $(MAIN_SRC) $(AUX_SRCS)

# Objetos generados a partir de los .s
OBJS = $(patsubst %.s,$(BUILD)/%.o,$(SRCS))


# ----------------------------------------------------------
# Flags
# ----------------------------------------------------------
# -g  : genera información de depuración (DWARF)
ASFLAGS = -g

# No se utilizan librerías externas
LDFLAGS =


# ----------------------------------------------------------
# Targets principales
# ----------------------------------------------------------

# Target por defecto: compila y enlaza todo
all: $(TARGET)


# ----------------------------------------------------------
# Reglas de construcción
# ----------------------------------------------------------

# Crear el directorio build si no existe
$(BUILD):
	mkdir -p $(BUILD)

# Ensamblado de cualquier archivo .s a .o
# $< : archivo fuente
# $@ : archivo destino
$(BUILD)/%.o: %.s | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

# Enlazado final: genera el ejecutable ELF ARM64
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)


# ----------------------------------------------------------
# Ejecución
# ----------------------------------------------------------

# Ejecuta el programa ARM64 en QEMU (sin depuración)
run: $(TARGET)
	$(QEMU) $(TARGET)


# ----------------------------------------------------------
# Depuración (QEMU + GDB remoto)
# ----------------------------------------------------------

# Inicia QEMU en modo GDB stub
# El programa queda pausado esperando conexión en localhost:1234
gdb: $(TARGET)
	@echo "Starting QEMU and waiting for GDB on port 1234..."
	$(QEMU) -g 1234 $(TARGET)


# ----------------------------------------------------------
# Limpieza
# ----------------------------------------------------------

# Elimina archivos generados
clean:
	rm -rf $(BUILD)


# ----------------------------------------------------------
# Información de ayuda
# ----------------------------------------------------------

# Muestra los targets disponibles
info:
	@echo "Targets disponibles:"
	@echo "  make        -> ensambla y enlaza el programa ARM64"
	@echo "  make run    -> ejecuta el binario en QEMU"
	@echo "  make gdb    -> ejecuta QEMU y espera conexión de GDB (VS Code)"
	@echo "  make clean  -> elimina el directorio build/"
