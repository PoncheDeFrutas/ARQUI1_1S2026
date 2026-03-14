# Leccion 05 - Stack y funciones

## Objetivo de aprendizaje

Aplicar llamada a funcion en ARM64 con prologo/epilogo correcto, uso de stack pointer y preservacion de registros callee-saved segun ABI AArch64.

## Prerrequisitos

- Haber completado `../04_memory_load_store/README.md`.
- Entender `cmp`, branches y syscall `exit`.
- Tener disponible `make`, `gdb` y flujo de depuracion.

## Conceptos nuevos (3-5 maximo)

- Llamada a funcion con `bl` y retorno con `ret`.
- Uso de `x29` (frame pointer) y `x30` (link register).
- Prologo/epilogo con `stp` y `ldp` sobre stack.
- Preservacion de registros callee-saved (`x19`, `x20`).

## Explicacion clave: `sp`, `fp` (`x29`) y `lr` (`x30`)

- `sp` (stack pointer): apunta al tope actual de la pila. Cambia cuando haces push/pop.
- `x29` (frame pointer, `fp`): marca una base estable del frame actual para depurar y organizar la funcion.
- `x30` (link register, `lr`): guarda la direccion de retorno cuando ejecutas `bl`.

Por que se usan juntos en el prologo:

1. Al entrar a una funcion, guardas `x29` y `x30` para no perder el frame anterior ni la direccion de retorno.
2. Fijas `x29 = sp` para tener una referencia estable del frame actual.
3. Guardas registros callee-saved que la funcion va a modificar (`x19`, `x20`).

## Diagrama visual del stack en esta leccion

Estado al entrar a `suma_1_a_n` (antes del prologo):

```text
sp -> [tope actual del llamador]
```

Despues de:

```asm
stp x29, x30, [sp, #-16]!
mov x29, sp
stp x19, x20, [sp, #-16]!
```

queda:

```text
Direccion alta
...
[x29 viejo]            <- guardado por primer stp
[x30 viejo / retorno]  <- guardado por primer stp
[x19 viejo]            <- guardado por segundo stp
[x20 viejo]            <- guardado por segundo stp  <- sp actual
Direccion baja
```

`x29` queda apuntando al inicio del frame (donde se guardaron `x29/x30`). `sp` queda mas abajo porque se reservo espacio adicional para `x19/x20`.

Al final, el epilogo:

```asm
ldp x19, x20, [sp], #16
ldp x29, x30, [sp], #16
ret
```

deshace exactamente esos pasos en orden inverso.

Regla de oro: si bajas `sp` N bytes en el prologo, debes subirlo N bytes en el epilogo.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `bl etiqueta` | Llama funcion y guarda retorno en `x30` | Etiqueta de funcion valida | Transferir control a subrutina |
| `ret` | Regresa al llamador | `x30` con direccion de retorno valida | Volver a `_start` o funcion previa |
| `stp ra, rb, [sp, #-16]!` | Guarda dos registros y mueve `sp` | Registros fuente y stack valido | Prologo y reserva de contexto |
| `ldp ra, rb, [sp], #16` | Restaura dos registros y avanza `sp` | Stack con datos guardados | Epilogo y restauracion de contexto |
| `mov x29, sp` | Fija frame pointer actual | `sp` apuntando al frame activo | Facilitar depuracion y estructura de frame |

Variantes para practicar:

- `str/ldr` para guardar variables locales en stack.
- Mas registros callee-saved (`x21-x28`) si la funcion crece.

## Archivos de la leccion

```text
lessons/05_stack_and_functions/
|- README.md
|- main.s
`- Makefile
```

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

El programa no imprime texto y finaliza con codigo `0` si `suma_1_a_n(5)` retorna `15`.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `make run` termina con salida correcta (exit `0`).
- En GDB puedes ver `bl suma_1_a_n` y luego `ret`.
- Durante la funcion, `sp` baja/sube simetricamente por `stp/ldp`.
- `x30` cambia con `bl` (direccion de retorno) y se restaura antes de `ret`.
- `x29` queda como ancla del frame mientras la funcion esta activa.

Comandos utiles en GDB:

```gdb
break _start
break suma_1_a_n
run
si
info registers sp x29 x30 x19 x20
x/4gx $sp
bt
```

Mini-guia de observacion en GDB:

1. Para en `suma_1_a_n` y ejecuta `info registers sp x29 x30`.
2. Ejecuta una instruccion (`si`) sobre `stp x29, x30, [sp, #-16]!` y vuelve a revisar registros.
3. Repite tras `mov x29, sp` para ver que `x29` ahora apunta al frame actual.
4. Antes de `ret`, verifica que `ldp` restaura `x29/x30`.

## Errores comunes

- No restaurar registros guardados antes de `ret`.
- Romper simetria de stack (`stp` sin `ldp` correspondiente).
- Usar registros callee-saved sin preservarlos.
- Confundir `x30` (retorno) con un registro temporal.

## Ejercicios propuestos

1. Cambia la funcion para calcular `suma_1_a_n(10)` y valida `55`.
2. Implementa una segunda funcion `doble(n)` y llamala desde `_start`.
3. Guarda temporalmente una variable local en stack con `str/ldr`.

## Criterios de evaluacion sugeridos

- **Correctitud:** la funcion retorna el valor esperado.
- **Disciplina de ABI:** prologo/epilogo y registros preservados correctamente.
- **Depuracion:** evidencia clara del frame y de cambios en `sp`.

## Proxima leccion

- [Leccion 06 - ABI y multiarchivo](../06_abi_and_multifile/README.md)
