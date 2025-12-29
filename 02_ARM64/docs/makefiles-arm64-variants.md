# Makefiles ARM64: QEMU en host x86 vs. variantes nativas

## Objetivo

Dejar en un solo lugar las copias de los Makefiles actuales (pensados para host x86 + QEMU user-mode) y sus variantes para ejecutarse directamente en una máquina **AArch64 nativa** sin QEMU. Incluye notas de uso y diferencias clave.

---

## 0. Targets disponibles (aplican a todas las variantes)

- `make` / `make all`: ensambla y enlaza el binario (con símbolos de depuración `-g`).
- `make run`: ejecuta el binario. En host x86 usa `qemu-aarch64`; en host ARM64 lo ejecuta directamente.
- `make gdb`: lanza depuración. En x86 arranca QEMU con stub GDB en `localhost:1234`; en ARM64 abre `gdb` local sobre el binario.
- `make clean`: borra el directorio `build/`.
- `make info`: muestra un resumen de los targets disponibles.

---

## 1. Copias de los Makefiles actuales (host x86 + QEMU)

### 1.1 `lessons/00_hello_world/Makefile` (flujo mínimo)

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

### 1.2 `lessons/99_test/Makefile` (flujo multi-fuente)

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
	@echo "  make        -> ensambla y enlaza el programa ARM64"
	@echo "  make run    -> ejecuta el binario en QEMU"
	@echo "  make gdb    -> ejecuta QEMU y espera conexión de GDB (VS Code)"
	@echo "  make clean  -> elimina el directorio build/"
```

---

## 2. Variantes para host ARM64 nativo (sin QEMU)

Pensadas para una máquina AArch64 física o una VM/contendor AArch64, donde se ejecuta el binario directamente (sin emulación). Se mantienen los mismos targets para no cambiar hábitos.

### 2.1 `Makefile` nativo (lección 00, flujo mínimo)

```makefile
# ==========================================================
# Lección 00 – Hello World en ARM64 (Linux) – Host ARM64 nativo
# Build:  as + ld (toolchain nativa)
# Run  :  ejecución directa (sin QEMU)
# Debug:  gdb local
# ==========================================================

# ---------------------------------------------------------
# Toolchain (host ARM64)
# ---------------------------------------------------------
AS      = as                    # o aarch64-linux-gnu-as si prefieres el prefijo
LD      = ld

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
ASFLAGS = -g                    # símbolos de depuración
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

# Ejecutar directamente en host ARM64
run: $(BIN)
	$(BIN)

# ---------------------------------------------------------
# Debug local (sin QEMU)
# ---------------------------------------------------------
gdb: $(BIN)
	gdb $(BIN)

# ---------------------------------------------------------
# Limpieza
# ---------------------------------------------------------
clean:
	rm -rf $(BUILD)

# ---------------------------------------------------------
# Utilidades
# ---------------------------------------------------------
info:
	@echo "Targets:"
	@echo "  make        -> compila el programa"
	@echo "  make run    -> ejecuta directamente en ARM64"
	@echo "  make gdb    -> abre gdb local"
	@echo "  make clean  -> limpia build/"
```

### 2.2 `Makefile` nativo (lección 99, multi-fuente)

```makefile
# ==========================================================
# Makefile – Programas AArch64 en host ARM64 nativo (sin QEMU)
# Build:  as + ld (toolchain nativa)
# Run  :  ejecución directa
# Debug:  gdb local
# ==========================================================

# ----------------------------------------------------------
# Toolchain (host ARM64)
# ----------------------------------------------------------
AS      = as                    # o aarch64-linux-gnu-as si está instalado
LD      = ld

# ----------------------------------------------------------
# Rutas y nombres de salida
# ----------------------------------------------------------
BUILD   = build
TARGET  = $(BUILD)/main

# ----------------------------------------------------------
# Fuentes
# ----------------------------------------------------------
MAIN_SRC = main.s
AUX_SRCS = $(filter-out $(MAIN_SRC), $(wildcard *.s))
SRCS     = $(MAIN_SRC) $(AUX_SRCS)
OBJS     = $(patsubst %.s,$(BUILD)/%.o,$(SRCS))

# ----------------------------------------------------------
# Flags
# ----------------------------------------------------------
ASFLAGS = -g
LDFLAGS =

# ----------------------------------------------------------
# Targets principales
# ----------------------------------------------------------

all: $(TARGET)

# Crear el directorio build si no existe
$(BUILD):
	mkdir -p $(BUILD)

# Ensamblado de cualquier archivo .s a .o
$(BUILD)/%.o: %.s | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

# Enlazado final
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# ----------------------------------------------------------
# Ejecución (sin QEMU)
# ----------------------------------------------------------
run: $(TARGET)
	$(TARGET)

# ----------------------------------------------------------
# Depuración local
# ----------------------------------------------------------
gdb: $(TARGET)
	gdb $(TARGET)

# ----------------------------------------------------------
# Limpieza
# ----------------------------------------------------------
clean:
	rm -rf $(BUILD)

# ----------------------------------------------------------
# Información de ayuda
# ----------------------------------------------------------
info:
	@echo "Targets:"
	@echo "  make        -> ensambla y enlaza en ARM64 nativo"
	@echo "  make run    -> ejecuta directo"
	@echo "  make gdb    -> abre gdb local"
	@echo "  make clean  -> elimina build/"
```

---

## 3. Diferencias clave (QEMU vs. nativo)

- **Toolchain:** cruzada con prefijo `aarch64-linux-gnu-*` (host x86) vs. toolchain nativa `as/ld` en host ARM64.
- **Ejecución:** `qemu-aarch64 <bin>` o `qemu-aarch64 -g 1234 <bin>` para emulación y depuración remota; en nativo se invoca el binario directamente.
- **Depuración:** en QEMU se usa un stub GDB remoto en `localhost:1234` (útil para VS Code con `miDebuggerServerAddress`); en nativo se puede usar `gdb` local (o `gdb-multiarch` sin stub). Si se usa VS Code en nativo, basta configurar `cppdbg` con `program` y `cwd` sin `miDebuggerServerAddress`.
- **Portabilidad:** los Makefiles con QEMU permiten trabajar en host x86; los nativos eliminan la dependencia de emulación pero requieren hardware/VM ARM64.
- **Rendimiento:** en nativo la ejecución es directa; en QEMU hay sobrecosto de traducción dinámica.

---

## 4. Uso sugerido

- En host x86: usa los Makefiles originales (secciones 1.1 y 1.2) para construir/ejecutar con QEMU y depurar con VS Code mediante GDB remoto.
- En host ARM64: cambia el Makefile por su variante nativa (2.1 o 2.2) o guárdalo como `Makefile.native` para alternar; ejecuta `make`, `make run` y `make gdb` sin QEMU.
