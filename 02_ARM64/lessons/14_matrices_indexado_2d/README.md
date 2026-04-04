# Leccion 14 - Matrices indexado 2D

## Objetivo de aprendizaje

Entender que una matriz 2D en ARM64 sigue almacenandose como memoria lineal, y aprender a calcular la direccion de `A[i][j]` en los layouts row-major y column-major.

## Prerrequisitos

- Haber completado `../13_arreglos_1d/README.md`.
- Entender `mul`, `add`, `ldr`, `str` y multiplicacion por `elem_size`.
- Entender arreglos lineales de `.quad`.

## Conceptos nuevos (3-5 maximo)

- Layout row-major.
- Layout column-major.
- Formula de direccionamiento para `A[i][j]`.
- Validacion basica de limites (`i < rows`, `j < cols`).

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mul` | Construye parte del indice lineal | `i`, `j`, `rows`, `cols` | Calcular offset 2D |
| `add` | Suma base, indices y offset | Base y temporales | Obtener direccion final |
| `ldr/str` | Lee o escribe una celda | Direccion valida | Acceder elementos de matriz |
| `cmp` + `b.hs` | Verifica limites | `i`, `j`, `rows`, `cols` | Detectar accesos invalidos |
| `lsl #3` | Multiplica por 8 bytes | Indice lineal | Convertir indice a offset de `.quad` |

## Archivos de la leccion

```text
lessons/14_matrices_indexado_2d/
|- README.md
|- main.s
|- matrix_row_major_examples.s
|- matrix_col_major_examples.s
`- Makefile
```

- `main.s`: menu para elegir la demo.
- `matrix_row_major_examples.s`: lectura y escritura en row-major.
- `matrix_col_major_examples.s`: lectura en column-major y validacion de limites.

## Como se adapta una matriz a memoria lineal

Una matriz no se guarda como "filas y columnas" separadas en memoria. Se guarda como una secuencia lineal.

Para una matriz `rows x cols` de elementos `.quad`:

- cada elemento ocupa 8 bytes;
- primero se calcula el indice lineal;
- despues se convierte a bytes multiplicando por `8`.

Formulas de esta leccion:

```text
row-major:    offset = (i * cols + j) * 8
column-major: offset = (j * rows + i) * 8
```

La diferencia esta en que row-major agrupa por filas y column-major agrupa por columnas.

## Demos incluidas

1. Leer `A[1][2]` en una matriz `2x3` row-major y validar que el valor es `60`.
2. Leer el mismo `A[1][2]` en una matriz equivalente almacenada en column-major.
3. Escribir `99` en `A[1][1]` row-major y releer la posicion.
4. Detectar un acceso fuera de rango antes de calcular la direccion.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) leer A[1][2] row-major
2) leer A[1][2] column-major
3) escribir A[1][1] row-major
4) validar limites
Seleccion (1-4):
```

Cada opcion valida internamente el resultado y termina con `exit(0)` si el calculo es correcto.

## Verificacion (checklist)

- Opcion 1 usa `offset = (1*3 + 2) * 8` y obtiene `60`.
- Opcion 2 usa `offset = (2*2 + 1) * 8` y tambien obtiene `60`.
- Opcion 3 escribe `99` solo en la celda objetivo.
- Opcion 4 detecta que `i = 2` es invalido para `rows = 2`.

## Errores comunes

- Intercambiar `rows` con `cols` al construir el indice lineal.
- Olvidar multiplicar el indice lineal por 8 para `.quad`.
- Usar formula row-major sobre datos guardados en column-major.
- Validar limites despues de acceder a memoria en vez de antes.

## Ejercicios propuestos

1. Cambia la posicion objetivo a `A[0][1]` y recalcula el offset.
2. Agrega lectura de la diagonal principal en una matriz `2x2`.
3. Implementa escritura segura en column-major.

## Criterios de evaluacion sugeridos

- **Correctitud:** las direcciones calculadas producen la celda esperada.
- **Modelo mental:** el estudiante puede explicar la diferencia entre ambos layouts.
- **Depuracion:** puede rastrear `i`, `j`, indice lineal y offset en bytes.

## Proxima leccion

- [Leccion 15 - Matrices operaciones](../15_matrices_operaciones/README.md)
