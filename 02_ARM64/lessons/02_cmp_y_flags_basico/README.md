# Leccion 02 - CMP y flags basico

## Objetivo de aprendizaje

Entender como `cmp` actualiza banderas (flags) y como esas banderas se usan con branches condicionales.

## Prerrequisitos

- Haber completado `../01_registros_y_mov/README.md`.
- Conocer registros y operaciones basicas.

## Conceptos nuevos (3-5 maximo)

- Flags de comparacion (`Z`, `N`, `V`).
- Branch condicional por igualdad (`b.ne`).
- Branch condicional signed menor (`b.lt`).

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `cmp xN, xM/#imm` | Compara (`xN - op2`) sin guardar resultado | Operandos validos | Actualizar flags |
| `b.ne etiqueta` | Salta si `Z=0` | `cmp` previo | Detectar desigualdad |
| `b.lt etiqueta` | Salta si signed menor | `cmp` previo | Comparaciones con signo |
| `exit` (`x8=93`) | Termina proceso | `x0` con codigo | Resultado de prueba |

## Archivos de la leccion

```text
lessons/02_cmp_y_flags_basico/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` incluye dos casos: igualdad y comparacion signed menor, con comentarios por bloque e instruccion.

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

`make run` debe terminar con `exit(0)`.

## Verificacion (checklist)

- `cmp 8,8` no entra en error.
- `cmp -2,1` activa `b.lt`.
- El programa finaliza con codigo `0`.

## Errores comunes

- Pensar que `cmp` guarda resultado en registro.
- Usar branch signed cuando se queria unsigned.
- Romper la logica de ramas al reordenar etiquetas.

## Ejercicios propuestos

1. Cambia valores del segundo caso y ajusta branch.
2. Agrega un tercer caso con `b.eq`.
3. Introduce un caso que termine en error para depurar.

## Criterios de evaluacion sugeridos

- **Correctitud:** branches acordes a flags.
- **Lectura de flags:** interpretacion correcta signed vs unsigned.
- **Depuracion:** inspeccion de flujo por etiquetas.

## Proxima leccion

- [Leccion 03 - If simple](../03_if_simple/README.md)
