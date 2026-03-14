# Leccion 04 - If else

## Objetivo de aprendizaje

Implementar una estructura `if/else` completa en ARM64, separando claramente la rama verdadera y falsa.

## Prerrequisitos

- Haber completado `../03_if_simple/README.md`.
- Entender `cmp` y branches condicionales.

## Conceptos nuevos (3-5 maximo)

- Dos ramas mutuamente excluyentes.
- Uso de etiqueta `else_branch`.
- Salto incondicional para evitar caer en la rama incorrecta.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `and x3, x1, #1` | Extrae bit menos significativo | Valor de entrada en `x1` | Determinar par/impar |
| `b.eq else_branch` | Salta a rama falsa | Flags de `cmp` | Separar `if` y `else` |
| `b end_if` | Salto incondicional | Etiqueta destino | Evitar ejecutar rama falsa |
| `mov x2, #...` | Escribe clase logica | Registro destino | Guardar resultado |

## Archivos de la leccion

```text
lessons/04_if_else/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` documenta entrada, evaluacion de condicion, rama verdadera, rama falsa y salida.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

```text
(sin salida en pantalla)
```

Con `x1=7`, debe terminar en `exit(0)`.

## Verificacion (checklist)

- La condicion detecta impar correctamente.
- Solo una rama escribe el valor final.
- Validacion retorna exito.

## Errores comunes

- No saltar a `end_if` y ejecutar ambas ramas.
- Mezclar rama verdadera/falsa.
- Confundir `and` con comparacion directa.

## Ejercicios propuestos

1. Cambia entrada a par y ajusta validacion esperada.
2. Reemplaza logica por `if (x1 > 100) ... else ...`.
3. Agrega contador de ramas tomadas.

## Criterios de evaluacion sugeridos

- **Correctitud:** rama correcta para cada caso.
- **Control de flujo:** uso correcto de etiquetas y saltos.
- **Depuracion:** verificacion de valores en cada rama.

## Proxima leccion

- [Leccion 05 - If elseif else](../05_if_elseif_else/README.md)
