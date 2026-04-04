# Leccion 16 - Multiplicacion matrices basica

## Objetivo de aprendizaje

Implementar `C = A x B` en ARM64 usando triple loop y un acumulador por celda. Al finalizar, el estudiante debe poder multiplicar una matriz `2x3` por una `3x2`, validar dimensiones y comprobar cada valor de salida.

## Prerrequisitos

- Haber completado `../15_matrices_operaciones/README.md`.
- Entender indexado 2D en row-major.
- Entender loops anidados y acumuladores.

## Conceptos nuevos (3-5 maximo)

- Triple loop (`i`, `j`, `k`).
- Acumulador por cada celda `C[i][j]`.
- Compatibilidad de dimensiones (`A.cols == B.rows`).
- Acceso combinado `A[i][k]` y `B[k][j]`.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mul` | Calcula productos parciales y offsets | Operandos, indices y dimensiones | Base del producto matricial |
| `add` | Acumula productos parciales | Acumulador y producto | Construir `C[i][j]` |
| Loops `i`, `j`, `k` | Recorre filas, columnas y eje comun | Limites correctos | Implementar el algoritmo completo |
| `cmp` + branches | Valida dimensiones y resultados | `colsA`, `rowsB`, esperados | Evitar errores de forma |
| `str` | Guarda la celda final calculada | Direccion de `C[i][j]` | Escribir la matriz resultado |

## Archivos de la leccion

```text
lessons/16_multiplicacion_matrices_basica/
|- README.md
|- main.s
|- matrix_mul_examples.s
`- Makefile
```

- `main.s`: llama la demo principal y finaliza con `exit(0)` o `exit(1)`.
- `matrix_mul_examples.s`: implementa validacion de dimensiones, triple loop y comparacion contra resultado esperado.

## Idea central del algoritmo

Para calcular una celda `C[i][j]`:

```text
C[i][j] = A[i][0]*B[0][j] + A[i][1]*B[1][j] + ... + A[i][k]*B[k][j]
```

Eso obliga a:

- fijar una fila `i` de `A`;
- fijar una columna `j` de `B`;
- recorrer `k` sobre la dimension comun;
- reiniciar el acumulador antes de cada nueva celda.

En esta leccion se usa:

- `A` de `2x3`;
- `B` de `3x2`;
- `C` de `2x2`.

## Caso trabajado

Se multiplica:

```text
A = [ [1, 2, 3],
      [4, 5, 6] ]

B = [ [ 7,  8],
      [ 9, 10],
      [11, 12] ]
```

Resultado esperado:

```text
C = [ [ 58,  64],
      [139, 154] ]
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
(sin salida en pantalla)
```

La demo valida internamente todas las celdas de `C` y termina con `exit(0)` si el producto es correcto.

## Verificacion (checklist)

- Se valida primero que `colsA == rowsB`.
- El acumulador se reinicia cada vez que cambia `j`.
- Cada `C[i][j]` coincide con el calculo manual esperado.
- La matriz final `2x2` coincide con `[58, 64, 139, 154]`.

## Errores comunes

- No reiniciar el acumulador al empezar una nueva celda.
- Confundir `B[k][j]` con `B[j][k]`.
- Multiplicar matrices incompatibles sin validar dimensiones.
- Escribir el resultado con la formula de offset equivocada.

## Ejercicios propuestos

1. Cambia `A` y `B` por otros valores y recalcula la matriz esperada.
2. Prueba una multiplicacion `2x2 * 2x2`.
3. Agrega una rama que detecte y reporte matrices incompatibles antes del loop.

## Criterios de evaluacion sugeridos

- **Correctitud:** la matriz resultado coincide con la referencia.
- **Algoritmo:** los loops `i`, `j`, `k` estan bien estructurados.
- **Depuracion:** el estudiante puede seguir el acumulador y los offsets de acceso.

## Proxima leccion

- [Leccion 17 - Proyecto IoT de datos](../17_proyecto_iot_datos/README.md)
