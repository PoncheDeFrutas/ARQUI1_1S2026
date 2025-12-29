# Makefile – Lección 99 (multi-fuente en ARM64)

Referencia para el Makefile flexible de `lessons/99_test`. Úsalo cuando la lección tenga **varios archivos `.s`** y quieras compilarlos todos sin tocar el Makefile (el punto de entrada sigue siendo `main.s`).

## Flujo y objetivos
- Detecta todos los `.s` del directorio; `main.s` actúa como entrada `_start`.
- Ensambla cada fuente a `build/*.o` con símbolos de depuración (`-g`).
- Enlaza todos los objetos en `build/main`.
- Ejecuta en QEMU (`make run`) o abre el stub de GDB (`make gdb`) para depurar desde VS Code.

## Comandos disponibles
- `make` : compila y enlaza todos los `.s`.
- `make run` : ejecuta el binario en QEMU.
- `make gdb` : arranca QEMU en modo depuración (GDB en `localhost:1234`).
- `make clean` : limpia `build/`.
- `make info` : muestra la ayuda breve.

## Pros y contras
- **Pros:** no requiere editar el Makefile al añadir fuentes; mantiene los mismos comandos que el flujo simple.
- **Contras:** siempre compila todos los `.s` del directorio; no permite seleccionar un subconjunto; requiere que `main.s` exista y defina `_start`.

## Código completo del Makefile

```makefile
# ==========================================================
# Makefile – Programas AArch64 (ARM64) en Linux
#
# Este Makefile permite:
#  - Ensamblar uno o más archivos AArch64 (.s)
#  - Enlazarlos en un único ejecutable ELF ARM64
#  - Ejecutar el binario en un host x86 usando QEMU (user-mode)
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
	@echo \"  make        -> ensambla y enlaza el programa ARM64\"
	@echo \"  make run    -> ejecuta el binario en QEMU\"
	@echo \"  make gdb    -> ejecuta QEMU y espera conexión de GDB (VS Code)\"
	@echo \"  make clean  -> elimina el directorio build/\"
```

