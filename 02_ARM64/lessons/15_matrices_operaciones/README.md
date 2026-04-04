# Leccion 15 - Matrices operaciones

## Objetivo de aprendizaje

Implementar operaciones basicas sobre matrices pequenas en ARM64: suma, resta y multiplicacion por escalar. Al finalizar, el estudiante debe poder recorrer una matriz completa con loops anidados y guardar el resultado en un buffer de salida.

## Prerrequisitos

- Haber completado `../14_matrices_indexado_2d/README.md`.
- Manejar direccionamiento 2D en row-major.
- Entender `add`, `sub`, `mul`, `ldr`, `str` y loops anidados.

## Conceptos nuevos (3-5 maximo)

- Operaciones elemento a elemento.
- Recorridos dobles (`i`, `j`).
- Buffer de salida separado de las matrices fuente.
- Validacion de dimensiones compatibles.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `add` | Suma celdas correspondientes | Dos matrices compatibles | Implementar suma matricial |
| `sub` | Resta celdas correspondientes | Dos matrices compatibles | Implementar resta matricial |
| `mul` | Multiplica una celda por escalar | Matriz y constante | Escalado uniforme |
| Loops anidados | Recorre `rows x cols` | Contadores `i` y `j` | Procesar toda la matriz |
| `cmp` + branches | Verifica dimensiones y resultados | Filas, columnas, esperados | Evitar operaciones invalidas |

## Archivos de la leccion

```text
lessons/15_matrices_operaciones/
|- README.md
|- main.s
|- matrix_ops_examples.s
`- Makefile
```

- `main.s`: menu de demos.
- `matrix_ops_examples.s`: implementa suma, resta, escalar y validacion de dimensiones.

## Idea central de la leccion

En suma y resta:

- se recorre la misma posicion `(i,j)` en dos matrices;
- se combina el valor;
- se guarda en una tercera matriz.

En escalar:

- se recorre una sola matriz;
- cada celda se multiplica por un valor fijo;
- el resultado se escribe en otra matriz.

Si las dimensiones no coinciden en suma o resta, la operacion no debe ejecutarse.

## Demos incluidas

1. Sumar dos matrices `2x2` y validar `[[11,22],[33,44]]`.
2. Restar dos matrices `2x2` y validar `[[8,6],[4,2]]`.
3. Multiplicar una matriz `2x2` por el escalar `3`.
4. Detectar incompatibilidad de dimensiones antes de operar.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) suma 2x2
2) resta 2x2
3) escalar 2x2
4) validar dimensiones
Seleccion (1-4):
```

Cada opcion valida internamente la matriz resultado y termina con `exit(0)` si la operacion es correcta.

## Verificacion (checklist)

- Opcion 1 suma correctamente las 4 celdas.
- Opcion 2 resta correctamente las 4 celdas.
- Opcion 3 multiplica cada celda por `3`.
- Opcion 4 rechaza matrices `2x2` y `2x3` como incompatibles.

## Errores comunes

- Usar el buffer fuente en vez del buffer resultado.
- Olvidar reiniciar `j` al cambiar de fila.
- Confundir una operacion elemento a elemento con multiplicacion matricial.
- No validar dimensiones antes de procesar.

## Ejercicios propuestos

1. Cambia las matrices de prueba y recalcula el resultado esperado.
2. Agrega una demo de transpuesta para una matriz `2x2`.
3. Extiende la suma para matrices `2x3`.

## Criterios de evaluacion sugeridos

- **Correctitud:** el contenido de la matriz resultado coincide celda por celda.
- **Estructura:** los loops `i` y `j` son claros y estan bien reiniciados.
- **Disciplina de memoria:** la escritura se hace en el buffer correcto.

## Proxima leccion

- [Leccion 16 - Multiplicacion matrices basica](../16_multiplicacion_matrices_basica/README.md)
