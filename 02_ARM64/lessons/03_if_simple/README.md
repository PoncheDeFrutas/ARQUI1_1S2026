# Leccion 03 - If simple

## Objetivo de aprendizaje

Traducir un `if` sencillo de alto nivel a ensamblador ARM64 usando `cmp` y un branch condicional.

## Prerrequisitos

- Haber completado `../02_cmp_y_flags_basico/README.md`.
- Entender comparaciones con `cmp`.

## Conceptos nuevos (3-5 maximo)

- Estructura minima de un `if`.
- Rama de no cumplimiento de condicion.
- Validacion de resultado logico.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `cmp x1, #20` | Compara entrada con umbral | Valor de entrada en `x1` | Evaluar condicion |
| `b.le after_if` | Salta si condicion no cumple | Flags de `cmp` | Evitar bloque `if` |
| `mov x2, #1` | Asigna resultado | Registro destino | Ejecutar rama verdadera |
| `exit` (`x8=93`) | Termina proceso | `x0` con estado | Reportar exito/error |

## Archivos de la leccion

```text
lessons/03_if_simple/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` muestra traduccion directa de `if (x1 > 20) x2 = 1;`.

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

Debe terminar con `exit(0)`.

## Verificacion (checklist)

- `x1=25` entra a rama verdadera.
- `x2` queda en `1`.
- Validacion final retorna `0`.

## Errores comunes

- Invertir la condicion del branch.
- Olvidar inicializar `x2`.
- Validar contra valor incorrecto.

## Ejercicios propuestos

1. Cambia umbral a `30` y ajusta entrada.
2. Usa otra variable de salida.
3. Haz un caso que deje `x2=0` y verifica error.

## Criterios de evaluacion sugeridos

- **Correctitud:** traduccion fiel del `if`.
- **Control de flujo:** salto correcto segun flags.
- **Depuracion:** seguimiento de etiquetas `after_if/error`.

## Proxima leccion

- [Leccion 04 - If else](../04_if_else/README.md)
