# Leccion 01 - Registros y mov

## Objetivo de aprendizaje

Comprender el uso basico de registros generales (`xN` y `wN`) y mover datos con `mov` para construir operaciones simples.

## Prerrequisitos

- Haber completado `../00_hello_world_syscalls/README.md`.
- Entender el uso de `make` y `make run`.

## Conceptos nuevos (3-5 maximo)

- Diferencia entre vista `xN` (64 bits) y `wN` (32 bits).
- Carga de inmediatos con `mov`.
- Operacion basica `add` en registros.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mov xD, #imm` | Carga inmediato en 64 bits | Registro destino e inmediato | Inicializar operandos |
| `add xD, xN, xM` | Suma registros | Dos fuentes y destino | Calculo basico |
| `cmp` + `b.ne` | Compara y salta si distinto | Valor esperado y flags | Validacion de resultado |
| `exit` (`x8=93`) | Termina proceso | `x0` con codigo | Reportar exito/error |

## Archivos de la leccion

```text
lessons/01_registros_y_mov/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` sigue el formato base: cabecera completa, registros usados, secciones separadas y comentarios por bloque e instruccion clave.

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

`make run` debe finalizar con `exit(0)`.

## Verificacion (checklist)

- Se genera `build/main`.
- La suma `5 + 10` queda en `x3`.
- La validacion pasa y retorna `0`.

## Errores comunes

- Confundir `xN` con `wN`.
- Validar contra valor incorrecto.
- Olvidar actualizar codigo de salida en rama de error.

## Ejercicios propuestos

1. Cambia operandos y valida otro resultado.
2. Usa un registro temporal adicional.
3. Cambia validacion para forzar la rama de error.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultado aritmetico correcto.
- **Disciplina de registros:** uso consistente de `xN`/`wN`.
- **Depuracion:** inspeccion de `x3` antes de `exit`.

## Proxima leccion

- [Leccion 02 - CMP y flags basico](../02_cmp_y_flags_basico/README.md)
