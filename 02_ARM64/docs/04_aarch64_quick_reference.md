# Referencia rapida AArch64 para el curso

Hoja de consulta para laboratorio. No reemplaza el material de lecciones.

## Registros generales

- `x0-x30`: registros de 64 bits.
- `w0-w30`: vista de 32 bits de los mismos registros.
- `sp`: stack pointer.
- `x30` (`lr`): link register (retorno de `bl`).
- `x29` (`fp`): frame pointer (cuando se usa stack frame).

## Convencion de llamada (ABI AArch64)

- Argumentos 1-8: `x0-x7`.
- Retorno: `x0`.
- Caller-saved: `x0-x18` (segun contexto, asumir temporales).
- Callee-saved: `x19-x29`.
- `x30` contiene la direccion de retorno.

## Syscalls Linux ARM64

- Numero de syscall en `x8`.
- Argumentos en `x0-x5`.
- Invocacion con `svc #0`.

Ejemplos frecuentes:

- `write`: syscall `64`
- `exit`: syscall `93`

## Instrucciones base muy usadas

- Movimiento y carga: `mov`, `adr`, `ldr`, `str`.
- Aritmetica: `add`, `sub`, `mul`.
- Logica: `and`, `orr`, `eor`.
- Comparacion/saltos: `cmp`, `b.eq`, `b.ne`, `b.lt`, `b.ge`, `b`.
- Llamadas/retorno: `bl`, `ret`.

## Banderas (NZCV)

- `N`: negativo.
- `Z`: cero.
- `C`: acarreo/borrow segun operacion.
- `V`: overflow con signo.

## Patrones de direccionamiento

- Base + inmediato: `[x0, #16]`
- Base + indice: `[x0, x1]`
- Post-index: `[x0], #8`
- Pre-index: `[x0, #8]!`

## Recordatorios utiles

- Escribe siempre un plan de registros antes de codificar.
- Respeta ABI al separar funciones.
- Documenta que representa cada bloque de memoria (bytes, elementos, stride).
