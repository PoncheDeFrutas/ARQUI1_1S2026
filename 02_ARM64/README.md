# 02_ARM64 - Ensamblador ARMv8 (AArch64) para IoT

Esta seccion contiene la ruta de aprendizaje de ensamblador ARM64 del curso, orientada a Raspberry Pi y sistemas IoT. El enfoque es progresivo: primero fundamentos de arquitectura y memoria en Linux user-mode; despues estructuras de datos, arreglos y matrices; finalmente base para MMIO/GPIO.

## Empieza aqui

1. Lee la [ruta formativa completa](docs/00_curriculum_path.md).
2. Configura tu entorno con la [guia de setup y flujos](docs/01_setup_and_workflows.md).
3. Revisa el [indice de lecciones](lessons/README.md).
4. Usa la [guia de depuracion](docs/02_debugging.md) cuando ejecutes practicas.

## Documentacion por tema

- [00 - Ruta de aprendizaje ARM64](docs/00_curriculum_path.md)
- [01 - Setup y flujos (Raspberry Pi o QEMU)](docs/01_setup_and_workflows.md)
- [02 - Depuracion con GDB y VS Code](docs/02_debugging.md)
- [03 - Uso de Makefiles y plantillas](docs/03_makefile_usage.md)
- [04 - Referencia rapida AArch64](docs/04_aarch64_quick_reference.md)
- [05 - Memoria y tipos de datos](docs/05_memory_and_data_types.md)
- [06 - Arreglos y matrices en ARM64](docs/06_arrays_and_matrices.md)

## Estructura de la carpeta

- `lessons/`: practicas y ejercicios por nivel.
- `docs/`: guias tecnicas y pedagogicas.
- `.vscode/`: configuraciones de depuracion.
- `tools/makefile-templates/`: plantillas de Makefile para host ARM64 y host x86_64 + QEMU.

## Comandos base en casi todas las lecciones

- `make`: ensambla y enlaza.
- `make run`: ejecuta el binario (nativo o con QEMU segun Makefile).
- `make gdb`: prepara depuracion (GDB local o QEMU stub).
- `make clean`: limpia `build/`.
- `make info`: muestra ayuda rapida.

## Alcance actual

- ARM64 en Linux user-mode.
- Syscalls y ABI AArch64.
- Memoria, stack, registros y funciones.
- Sin bare-metal y sin GPIO de bajo nivel por ahora.

La meta didactica es que el estudiante domine direccionamiento y uso eficiente de memoria antes de pasar a operaciones con datos complejos y control de perifericos.
