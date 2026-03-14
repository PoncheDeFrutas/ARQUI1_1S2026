# Leccion 10 - Stack y funciones

## Objetivo de aprendizaje

Aplicar llamada a funcion con prologo/epilogo, preservacion de registros y retorno correcto siguiendo ABI AArch64.

## Prerrequisitos

- Haber completado `../09_memoria_load_store_basico/README.md`.
- Entender loops y branches.

## Conceptos nuevos (3-5 maximo)

- `bl` y `ret`.
- Uso de `x29` (fp) y `x30` (lr).
- Preservacion de registros callee-saved.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `bl funcion` | Llama funcion y guarda retorno | Etiqueta valida | Modularizar logica |
| `stp/ldp` con `sp` | Guarda/restaura pares | Stack alineado | Prologo/epilogo |
| `ret` | Regresa al llamador | `x30` valido | Volver a `_start` |
| `cmp` + `b.ne` | Valida retorno de funcion | Valor esperado | Asegurar correctitud |

## Archivos de la leccion

```text
lessons/10_stack_y_funciones/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` contiene `_start` y `suma_1_a_n`, con comentarios explicitos de prologo, loop y epilogo.

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

Debe terminar con `exit(0)` validando `suma_1_a_n(5)=15`.

## Verificacion (checklist)

- `bl` entra y `ret` vuelve correctamente.
- `sp` se restaura al salir de funcion.
- `x19/x20` se preservan y restauran.

## Errores comunes

- No restaurar registros antes de `ret`.
- Desbalancear `sp` en prologo/epilogo.
- Reusar `x30` como temporal.

## Ejercicios propuestos

1. Cambia argumento a `10` y valida `55`.
2. Agrega funcion auxiliar y llamala desde `_start`.
3. Guarda variable local en stack con `str/ldr`.

## Criterios de evaluacion sugeridos

- **Correctitud:** retorno esperado.
- **Disciplina ABI:** manejo correcto de frame y registros.
- **Depuracion:** trazas claras en stack y retorno.

## Proxima leccion

- [Leccion 11 - ABI y multiarchivo](../11_abi_y_multiarchivo/README.md)
