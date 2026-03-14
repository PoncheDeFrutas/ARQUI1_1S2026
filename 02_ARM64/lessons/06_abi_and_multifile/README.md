# Leccion 06 - ABI y multiarchivo

## Objetivo de aprendizaje

Aplicar la convencion de llamada AArch64 entre varios archivos (`main.s` y `abi_examples.s`), distinguiendo registros caller-saved y callee-saved, con un ejemplo facil de validar.

## Prerrequisitos

- Haber completado `../05_stack_and_functions/README.md`.
- Entender `bl`, `ret`, `sp`, `x29` y `x30`.
- Conocer salida por syscall `exit`.

## Conceptos nuevos (3-5 maximo)

- ABI entre modulos (multiarchivo).
- Argumentos en `x0-x7` y retorno en `x0`.
- Diferencia entre caller-saved y callee-saved.
- Funcion leaf vs no-leaf.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `bl etiqueta` | Llama funcion y guarda retorno en `x30` | Etiqueta/export simbolo valido | Transferir control entre modulos |
| `ret` | Regresa al llamador | `x30` valido | Volver a quien invoco la funcion |
| `stp/ldp` con `sp` | Guardar/restaurar pares de registros | Stack alineado y simetria push/pop | Prologo/epilogo en funciones no-leaf |
| `str/ldr` con `sp` | Guardar/restaurar registro individual | Offset valido en stack | Preservar callee-saved (ej. `x19`) |
| `mul` | Multiplica dos registros | Operandos en registros | Aplicar escala al resultado |

## Reglas ABI usadas en este ejemplo

- **Argumentos:** `x0`, `x1`, `x2`.
- **Retorno:** `x0`.
- **Caller-saved (ejemplo):** `x0-x18` pueden cambiar tras una llamada.
- **Callee-saved (ejemplo):** `x19-x29` deben restaurarse si la funcion los usa.

En `combine_and_scale`, la escala llega en `x2` (caller-saved). Como la funcion llama a `sum2`, primero copia `x2` en `x19` (callee-saved) y preserva/restaura `x19` en stack.

## Archivos de la leccion

```text
lessons/06_abi_and_multifile/
|- README.md
|- main.s
|- abi_examples.s
`- Makefile
```

- `main.s`: prepara argumentos, llama funcion externa y valida.
- `abi_examples.s`: implementa `sum2` y `combine_and_scale`.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

El programa no imprime texto y finaliza con codigo `0` si `(4 + 6) * 3 = 30`.

## Verificacion (checklist)

- `build/main` se genera con ambos archivos ensamblados.
- `make run` termina con `exit(0)`.
- En GDB, `bl combine_and_scale` y `bl sum2` se ejecutan correctamente.
- `x19` se restaura antes de `ret` en `combine_and_scale`.

Comandos utiles en GDB:

```gdb
break _start
break combine_and_scale
break sum2
run
si
info registers x0 x1 x2 x19 x29 x30 sp
x/4gx $sp
```

## Errores comunes

- Usar `x19` sin guardarlo/restaurarlo en funcion no-leaf.
- Confiar en que `x2` se conserva despues de `bl`.
- Romper simetria del stack en prologo/epilogo.
- Olvidar exportar simbolos con `.global`.

## Ejercicios propuestos

1. Cambia entrada a `(2 + 8) * 4` y valida `40`.
2. Agrega funcion `diff2(a,b)` en `abi_examples.s` y llamala desde `main.s`.
3. Modifica `combine_and_scale` para usar una llamada extra y verifica que ABI siga correcto.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultado matematico correcto.
- **Disciplina ABI:** preservacion y restauracion de registros correcta.
- **Multiarchivo:** separacion limpia entre `main.s` y modulo de funciones.

## Proxima leccion

- [Leccion 07 - tipos de datos y extension de signo/cero](../07_data_types_sign_zero_extension/README.md)
