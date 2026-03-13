# Leccion 01 - Registros y mov en ARM64

## Objetivo de aprendizaje

Comprender el uso basico de registros generales (`xN` y `wN`) y mover valores entre registros e inmediatos con `mov`, preparando la base para operaciones aritmeticas y control de flujo.

## Prerrequisitos

- Haber completado `../00_hello_world/README.md`.
- Conocer `_start` y syscall `exit`.
- Entorno funcionando con `make`.

## Conceptos nuevos (3-5 maximo)

- Diferencia entre registros `xN` (64 bits) y `wN` (32 bits).
- Carga de inmediatos con `mov`.
- Copia de valores entre registros.
- Uso de un resultado en `x0` como codigo de salida.

## Archivos de la leccion

```text
lessons/01_registers_and_mov/
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

El programa no imprime texto y finaliza con codigo `0`.

## Verificacion (checklist)

- `build/main` se genera correctamente.
- `make run` termina sin error de ejecucion.
- En GDB puedes observar `x3 = 15` antes de `svc #0`.

## Errores comunes

- Esperar salida por pantalla cuando solo se usa `exit`.
- Usar `wN` y perder parte alta del registro sin notarlo.
- Colocar mal el numero de syscall en `x8`.

## Ejercicios propuestos

1. Cambia los operandos para que el codigo de salida sea `42`.
2. Guarda el resultado en `x0` y observa como cambia el estado de `make run`.
3. Prueba que pasa si escribes el resultado en `w3` en lugar de `x3`.

## Criterios de evaluacion sugeridos

- **Correctitud:** codigo de salida esperado.
- **Disciplina de registros:** uso claro de `xN` y `wN`.
- **Depuracion:** verificacion de registros antes de la syscall.

## Proxima leccion

- Leccion 02 - ALU y banderas.
