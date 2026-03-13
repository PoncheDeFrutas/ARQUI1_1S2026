# Setup y flujos de trabajo ARM64

Guia unica para preparar el entorno y escoger flujo de ejecucion segun tu hardware.

## 1) Elige tu flujo

- **Tienes Raspberry Pi ARM64** -> flujo nativo.
- **No tienes ARM64 y usas x86_64** -> flujo cruzado + QEMU.

La fuente en ensamblador es la misma en ambos casos.

## 2) Requisitos comunes

- Linux.
- `make`.
- VS Code + extension C/C++ (opcional para depuracion grafica).

## 3) Flujo nativo en Raspberry Pi (ARM64)

### Instalacion

```bash
sudo apt update
sudo apt install -y binutils gdb build-essential
```

### Comandos tipicos (dentro de una leccion)

```bash
make
make run
make gdb
```

### Toolchain esperada

- `as`, `ld`, `gdb`.

Usa plantilla `tools/makefile-templates/Makefile.arm64.single` o `Makefile.arm64.multi`.

## 4) Flujo x86_64 + QEMU

### Instalacion

```bash
sudo apt update
sudo apt install -y binutils-aarch64-linux-gnu qemu-user gdb-multiarch build-essential
```

### Comandos tipicos (dentro de una leccion)

```bash
make
make run
make gdb
```

### Toolchain esperada

- `aarch64-linux-gnu-as`, `aarch64-linux-gnu-ld`, `qemu-aarch64`, `gdb-multiarch`.

Usa plantilla `tools/makefile-templates/Makefile.qemu.single` o `Makefile.qemu.multi`.

## 5) Checklist rapido de entorno

- `make` genera `build/main` sin error.
- `make run` produce salida esperada.
- `make gdb` deja el programa listo para depurar.
- El README de la leccion describe objetivos y validacion.

## 6) Errores comunes

- Mezclar plantilla de Makefile nativa en host x86_64.
- No tener `qemu-aarch64` instalado cuando corresponde.
- Olvidar limpiar y recompilar despues de cambios: `make clean && make`.

## 7) Siguiente lectura

- [Depuracion con GDB y VS Code](02_debugging.md)
- [Uso de Makefiles y plantillas](03_makefile_usage.md)
