# Setup y flujos de trabajo RISC-V

Guia unica para preparar el entorno de la seccion RISC-V y ejecutar las lecciones en Linux user-mode con emulacion.

## 1) Flujo oficial de esta seccion

- Host Linux `x86_64` o `ARM64`.
- Toolchain cruzada `riscv64-linux-gnu-*`.
- Ejecucion con `qemu-riscv64`.
- Depuracion con `gdb-multiarch`.

La fuente en ensamblador es la misma para build, ejecucion y depuracion.

## 2) Requisitos comunes

- Linux.
- `make`.
- VS Code + extension C/C++ (opcional para depuracion grafica).
- Extension `StackScope` (opcional para inspeccion visual de stack y memoria).

## 3) Instalacion

```bash
sudo apt update
sudo apt install -y \
  binutils-riscv64-linux-gnu \
  qemu-user \
  gdb-multiarch \
  build-essential
```

## 4) Comandos tipicos (dentro de una leccion)

```bash
make
make run
make gdb
```

## 5) Toolchain esperada

- `riscv64-linux-gnu-as`
- `riscv64-linux-gnu-ld`
- `qemu-riscv64`
- `gdb-multiarch`

Usa plantilla `tools/makefile-templates/Makefile.qemu.single` o `Makefile.qemu.multi`.

## 6) Checklist rapido de entorno

- `make` genera `build/main` sin error.
- `make run` produce salida esperada.
- `make gdb` deja el programa listo para depurar.
- El README de la leccion describe objetivos y validacion.

## 7) Errores comunes

- No tener `qemu-riscv64` instalado.
- Usar una toolchain de otra arquitectura por error.
- Olvidar recompilar despues de cambios: `make clean && make`.

## 8) Siguiente lectura

- [Depuracion con GDB y VS Code](02_debugging.md)
- [Uso de Makefiles y plantillas](03_makefile_usage.md)
