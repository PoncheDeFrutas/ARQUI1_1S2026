# Leccion 05 - If elseif else

## Objetivo de aprendizaje

Traducir una cadena `if / else if / else` y organizar etiquetas para mantener flujo claro y mantenible.

## Prerrequisitos

- Haber completado `../04_if_else/README.md`.
- Entender comparaciones y saltos condicionales.

## Conceptos nuevos (3-5 maximo)

- Cadena de decision secuencial.
- Priorizacion de condiciones.
- Clase de salida segun categoria.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `cmp x1, #0` | Compara con cero | `x1` inicializado | Clasificar signo del valor |
| `b.eq / b.gt / b` | Selecciona rama | Flags y etiquetas | Resolver if/elseif/else |
| `mov x2, #clase` | Guarda clase final | Registro destino | Registrar resultado de decision |
| `cmp x2, #2` | Valida clasificacion | Resultado esperado | Confirmar logica correcta |

## Archivos de la leccion

```text
lessons/05_if_elseif_else/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` separa explicitamente ramas `is_zero`, `is_positive`, `is_negative` y validacion final.

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

Con `x1=-3`, debe terminar con `exit(0)` y clase `x2=2`.

## Verificacion (checklist)

- Se toma la rama negativa para `x1=-3`.
- `x2` termina en valor de clase correcto.
- `exit(0)` en el caso esperado.

## Errores comunes

- Orden incorrecto de comparaciones.
- Saltar a etiqueta equivocada.
- No unificar salida por `end_case`.

## Ejercicios propuestos

1. Cambia entrada a `0` y verifica clase cero.
2. Cambia entrada a positivo y verifica clase positiva.
3. Reescribe con etiquetas distintas manteniendo logica.

## Criterios de evaluacion sugeridos

- **Correctitud:** clase correcta para varios casos.
- **Control de flujo:** etiquetas y saltos ordenados.
- **Depuracion:** traza clara de rama tomada.

## Proxima leccion

- [Leccion 06 - Loops while y for](../06_loops_while_for/README.md)
