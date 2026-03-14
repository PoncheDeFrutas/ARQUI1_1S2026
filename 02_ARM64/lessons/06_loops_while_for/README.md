# Leccion 06 - Loops while y for

## Objetivo de aprendizaje

Comparar la implementacion de `while` y `for` en ensamblador ARM64 usando el mismo problema: sumar de 1 a 5.

## Prerrequisitos

- Haber completado `../05_if_elseif_else/README.md`.
- Entender `cmp` y branches condicionales.

## Conceptos nuevos (3-5 maximo)

- Estructura de ciclo `while`.
- Estructura de ciclo `for`.
- Variables de control (contador y acumulador).
- Validacion final del resultado.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `cmp` + `b.gt` | Evalua condicion de salida | Contador y limite | Cerrar ciclos |
| `add` | Incrementa contador/acumulador | Registros con datos | Avance del loop |
| `b etiqueta` | Repite bloque | Etiqueta valida | Volver al inicio de ciclo |
| `read`/`write` | Menu simple de demos | Syscalls y buffer | Elegir while o for |

## Archivos de la leccion

```text
lessons/06_loops_while_for/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` contiene menu de opcion y dos demos: `demo_while` y `demo_for`.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) while suma 1..5
2) for suma 1..5
Seleccion (1-2):
```

Ambas opciones deben terminar en `exit(0)`.

## Verificacion (checklist)

- Opcion 1 valida suma `15`.
- Opcion 2 valida suma `15`.
- Contador y acumulador cambian como se espera.

## Errores comunes

- No actualizar contador (loop infinito).
- Condicion invertida en `b.gt`.
- Reusar registros sin reinicializarlos entre demos.

## Ejercicios propuestos

1. Cambia rango a `1..10`.
2. Implementa suma de pares.
3. Agrega opcion de loop descendente.

## Criterios de evaluacion sugeridos

- **Correctitud:** suma final correcta.
- **Control de flujo:** loops terminan cuando corresponde.
- **Depuracion:** seguimiento de `i` y `suma`.

## Proxima leccion

- [Leccion 07 - ALU matematica basica](../07_alu_matematica_basica/README.md)
