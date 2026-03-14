# Leccion 14 - Matrices indexado 2D

## Objetivo de aprendizaje

Entender representacion de matrices en memoria lineal y aplicar formulas de direccionamiento en row-major y column-major.

## Prerrequisitos

- Haber completado `../13_arreglos_1d/README.md`.
- Entender multiplicacion por `elem_size`.

## Conceptos nuevos (3-5 maximo)

- Layout row-major.
- Layout column-major.
- Formula de acceso `A[i][j]`.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mul` | Calcula indice lineal parcial | `i`, `cols/rows` | Construir offset 2D |
| `add` | Combina indice y base | Offset y base | Obtener direccion final |
| `ldr/str` | Lee/escribe elemento matriz | Direccion calculada | Operar matriz |
| `cmp` + bounds | Verifica limites | `i`,`j`,`rows`,`cols` | Evitar accesos invalidos |

## Archivos de la leccion

```text
lessons/14_matrices_indexado_2d/
|- README.md
|- main.s                       (pendiente)
|- matrix_row_major_examples.s  (pendiente)
|- matrix_col_major_examples.s  (pendiente)
`- Makefile                     (pendiente)
```

## Estado actual

Leccion planificada para iteracion posterior.

## Estandar para archivos `.s`

Los modulos de matrices deben usar el mismo estandar de comentarios del curso para dejar explicito como se calculan offsets y direcciones.

## Flujo de trabajo

```bash
make
make run
make gdb
```

(Disponible cuando se implemente el codigo.)

## Salida esperada

Menu con demos de acceso a matriz en row-major y column-major.

## Verificacion (checklist)

- `addr(i,j)` coincide con valor esperado.
- Diferencia entre row-major y column-major clara.
- Accesos fuera de rango detectados en validacion.

## Errores comunes

- Intercambiar `rows` y `cols` en formula.
- Olvidar multiplicar por `elem_size`.
- Reusar indice lineal de layout equivocado.

## Ejercicios propuestos

1. Calcular y validar `addr(1,2)` en ambos layouts.
2. Leer diagonal principal de matriz cuadrada.
3. Implementar escritura segura con verificacion de limites.

## Criterios de evaluacion sugeridos

- **Correctitud:** direccionamiento 2D correcto.
- **Modelo mental:** diferencia clara de layouts.
- **Depuracion:** inspeccion de direcciones calculadas.

## Proxima leccion

- [Leccion 15 - Matrices operaciones](../15_matrices_operaciones/README.md)
