# Leccion 00 - Hello World en ARM64 (Linux)

## Objetivo de aprendizaje

Ejecutar el primer programa en ensamblador AArch64 en Linux sin libc, usando syscalls directas para escribir en pantalla y finalizar el proceso.

## Prerrequisitos

- Entorno configurado segun `../../docs/01_setup_and_workflows.md`.
- Conocer comandos basicos de terminal.
- Tener disponible `make` y toolchain de ARM64 (nativa o cruzada).

## Conceptos nuevos (3-5 maximo)

- Punto de entrada real `_start`.
- Convencion de syscalls Linux en ARM64 (`x0-x5`, `x8`, `svc #0`).
- Uso de secciones `.data` y `.text`.
- Ensamblado y enlace con `as` y `ld`.

## Archivos de la leccion

```text
lessons/00_hello_world/
|- README.md
|- main.s
`- Makefile
```

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

```text
Hello, world
```

## Verificacion (checklist)

- `build/main` se genera sin error.
- `make run` imprime `Hello, world`.
- En depuracion puedes detenerte en `_start`.
- Identificas en `main.s` el uso de `x0`, `x1`, `x2`, `x8`.

## Errores comunes

- No declarar `_start` como simbolo global.
- Colocar un numero de syscall incorrecto en `x8`.
- Confundir registros `wN` (32 bits) con `xN` (64 bits).
- No actualizar longitud del mensaje al cambiar el texto.

## Ejercicios propuestos

1. Cambia el mensaje y ajusta su longitud correctamente.
2. Imprime dos lineas separadas con dos llamadas `write`.
3. Finaliza con codigo de salida distinto de cero y verificable en shell.

## Criterios de evaluacion sugeridos

- **Correctitud:** el programa escribe y termina correctamente.
- **Disciplina de registros:** usa registros de syscall en el lugar correcto.
- **Depuracion:** demuestra inspeccion de registros en `_start`.

## Proxima leccion

- [Leccion 01 - Registros y mov](../01_registers_and_mov/README.md)
