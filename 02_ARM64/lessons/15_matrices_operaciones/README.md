# Leccion 15 - Matrices operaciones

## Objetivo de aprendizaje

Implementar operaciones basicas sobre matrices: suma, resta y multiplicacion por escalar.

## Prerrequisitos

- Haber completado `../14_matrices_indexado_2d/README.md`.
- Manejar direccionamiento 2D correctamente.

## Conceptos nuevos (3-5 maximo)

- Operaciones elemento a elemento.
- Recorridos dobles (`i`,`j`).
- Validacion de dimensiones compatibles.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `add/sub` | Suma o resta elementos | Dos matrices compatibles | Operaciones basicas |
| `mul` | Escala elemento | Matriz y escalar | Transformacion uniforme |
| Loops anidados | Recorre `rows x cols` | Contadores `i`,`j` | Procesar toda matriz |
| `cmp` de dimensiones | Verifica compatibilidad | `rows`,`cols` | Evitar operaciones invalidas |

## Archivos de la leccion

```text
lessons/15_matrices_operaciones/
|- README.md
|- main.s                  (pendiente)
|- matrix_ops_examples.s   (pendiente)
`- Makefile                (pendiente)
```

## Estado actual

Leccion planificada para implementacion posterior.

## Estandar para archivos `.s`

`main.s` y modulos de operaciones deben documentar por bloque cada loop (`i`,`j`) y el significado de cada registro de trabajo.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

Menu con operaciones de suma, resta y escalar sobre matrices pequenas.

## Verificacion (checklist)

- Suma y resta correctas en cada celda.
- Escalar aplica a toda la matriz.
- Detecta matrices incompatibles.

## Errores comunes

- Mezclar indices de fila/columna.
- Escribir resultado en buffer incorrecto.
- Omitir validacion de dimensiones.

## Ejercicios propuestos

1. Agrega transpuesta basica.
2. Soporta matrices no cuadradas en suma/resta.
3. Agrega verificacion automatica por caso de prueba.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultados por celda exactos.
- **Estructura:** loops dobles ordenados y claros.
- **Depuracion:** trazas por indice `(i,j)`.

## Proxima leccion

- [Leccion 16 - Multiplicacion matrices basica](../16_multiplicacion_matrices_basica/README.md)
