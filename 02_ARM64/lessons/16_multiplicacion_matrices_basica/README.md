# Leccion 16 - Multiplicacion matrices basica

## Objetivo de aprendizaje

Implementar `C = A x B` con triple loop en ARM64, validando dimensiones y acumulacion por celda.

## Prerrequisitos

- Haber completado `../15_matrices_operaciones/README.md`.
- Entender indexado 2D y loops anidados.

## Conceptos nuevos (3-5 maximo)

- Triple loop (`i`,`j`,`k`).
- Acumulador por celda de salida.
- Compatibilidad de dimensiones (`A.cols == B.rows`).

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mul` | Producto parcial `A[i,k]*B[k,j]` | Dos operandos | Base de multiplicacion |
| `add` | Acumula parciales | Acumulador y producto | Construir `C[i,j]` |
| Loops `i,j,k` | Recorre matrices | Limites correctos | Implementar algoritmo completo |
| `cmp` de dimensiones | Valida compatibilidad | `colsA`, `rowsB` | Evitar error de forma |

## Archivos de la leccion

```text
lessons/16_multiplicacion_matrices_basica/
|- README.md
|- main.s                     (pendiente)
|- matrix_mul_examples.s      (pendiente)
`- Makefile                   (pendiente)
```

## Estado actual

Leccion planificada para implementacion posterior.

## Estandar para archivos `.s`

La implementacion debe comentar explicitamente el rol de `i`, `j`, `k`, acumulador y formulas de direccion para cada acceso.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

Multiplicacion correcta en casos pequenos (ej. `2x3 * 3x2`).

## Verificacion (checklist)

- Validacion de dimensiones antes de calcular.
- Cada `C[i,j]` coincide con calculo manual.
- Acumulador se reinicia por celda.

## Errores comunes

- No resetear acumulador en cada `j`.
- Confundir orden de indices en `B[k,j]`.
- Olvidar validar dimensiones.

## Ejercicios propuestos

1. Prueba con matrices no cuadradas.
2. Compara dos ordenes de loops y discute costo.
3. Agrega test con resultado esperado fijo.

## Criterios de evaluacion sugeridos

- **Correctitud:** producto matricial correcto.
- **Algoritmo:** triple loop bien estructurado.
- **Depuracion:** seguimiento de acumulador y offsets.

## Proxima leccion

- [Leccion 17 - Proyecto IoT de datos](../17_proyecto_iot_datos/README.md)
