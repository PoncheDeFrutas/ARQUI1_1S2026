# Leccion 04 - Memoria, load y store

## Objetivo de aprendizaje

Introducir acceso a memoria en ARM64 con `ldr` y `str`, diferenciando entre trabajo en registros y datos almacenados en seccion `.data`.

## Prerrequisitos

- Haber completado `../03_branches_and_loops/README.md`.
- Entender operaciones en registros y branches.
- Entorno de depuracion disponible para inspeccionar memoria.

## Conceptos nuevos (3-5 maximo)

- Seccion `.data` para variables inicializadas.
- Carga de direccion base con `adr`.
- Lectura y escritura en memoria con `ldr` y `str`.
- Validacion de resultados leidos desde memoria.

## Archivos de la leccion

```text
lessons/04_memory_load_store/
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

El programa no imprime texto y finaliza con codigo `0` cuando el resultado guardado en memoria coincide con lo esperado.

## Verificacion (checklist)

- `build/main` se genera sin error.
- En GDB puedes inspeccionar `a`, `b` y `result` en memoria.
- Tras ejecutar las instrucciones de store, `result` vale `30`.
- El programa termina con `exit(0)` si la comparacion es correcta.

## Errores comunes

- Cargar valor cuando en realidad querias cargar direccion.
- Usar offset incorrecto al acceder a variables consecutivas.
- Sobrescribir la direccion base accidentalmente.

## Ejercicios propuestos

1. Cambia `a` y `b` y verifica nuevo resultado esperado.
2. Agrega una resta y guarda su resultado en otra variable.
3. Implementa un contador en memoria que incremente en loop.

## Criterios de evaluacion sugeridos

- **Correctitud:** lectura/escritura de memoria correcta.
- **Direccionamiento:** uso correcto de base + offset.
- **Depuracion:** verificacion de contenido en memoria.

## Proxima leccion

- Leccion 05 - Stack y funciones.
