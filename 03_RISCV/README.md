# 03_RISCV - Ensamblador RISC-V 64 para Linux

Esta seccion contiene la ruta base de aprendizaje de ensamblador RISC-V 64 del curso. El enfoque inicial es Linux user-mode con toolchain cruzada, QEMU y GDB, para que el estudiante practique registros, syscalls, memoria, stack y flujo de depuracion sin depender de hardware RISC-V nativo.

## Empieza aqui

1. Configura tu entorno con la [guia de setup y flujos](docs/01_setup_and_workflows.md).
2. Revisa la [guia de depuracion](docs/02_debugging.md) antes de usar VS Code y GDB.
3. Consulta el [uso de Makefiles y plantillas](docs/03_makefile_usage.md).
4. Abre el [indice de lecciones](lessons/README.md) para seguir la ruta disponible.

## Documentacion por tema

- [01 - Setup y flujos (toolchain cruzada + QEMU)](docs/01_setup_and_workflows.md)
- [02 - Depuracion con GDB y VS Code](docs/02_debugging.md)
- [03 - Uso de Makefiles y plantillas](docs/03_makefile_usage.md)

## Estructura de la carpeta

- `lessons/`: practicas y ejercicios por nivel.
- `docs/`: guias tecnicas y pedagogicas.
- `.vscode/`: configuraciones de depuracion para VS Code.
- `tools/makefile-templates/`: plantillas base de Makefile para flujo `single` y `multi`.

## Comandos base en casi todas las lecciones

- `make`: ensambla y enlaza.
- `make run`: ejecuta el binario con QEMU.
- `make gdb`: deja QEMU esperando conexion de GDB remoto.
- `make clean`: limpia `build/`.
- `make info`: muestra ayuda rapida.

## Alcance actual

- RISC-V 64 en Linux user-mode.
- Syscalls Linux RISC-V.
- Toolchain cruzada, QEMU user-mode y GDB remoto.
- Sin bare-metal y sin perifericos de bajo nivel por ahora.

La meta didactica de esta seccion es construir una base paralela a ARM64 para comparar ABI, registros, llamadas al sistema y flujos de depuracion sobre otra ISA moderna.
