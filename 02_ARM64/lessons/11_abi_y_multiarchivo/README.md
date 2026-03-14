# Leccion 11 - ABI y multiarchivo

## Objetivo de aprendizaje

Aplicar la convencion de llamada AArch64 entre varios archivos (`main.s` y `abi_examples.s`) preservando registros segun ABI.

## Prerrequisitos

- Haber completado `../10_stack_y_funciones/README.md`.
- Entender `bl`, `ret`, `sp`, `x29`, `x30`.

## Conceptos nuevos (3-5 maximo)

- Separacion de modulos en ensamblador.
- Registros caller-saved vs callee-saved.
- Funcion leaf y no-leaf.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `.extern` / `.global` | Declara simbolos entre modulos | Nombres consistentes | Enlace multiarchivo |
| `bl` | Llama funcion de otro archivo | Simbolo exportado | Reutilizar rutinas |
| `str/ldr` en stack | Guarda/restaura callee-saved | `sp` valido y simetria | Preservar `x19` |
| `mul` | Escala resultado | Operandos en registros | Calculo compuesto |

## Archivos de la leccion

```text
lessons/11_abi_y_multiarchivo/
|- README.md
|- main.s
|- abi_examples.s
`- Makefile
```

- `main.s`: prepara argumentos y valida retorno.
- `abi_examples.s`: implementa `sum2` y `combine_and_scale`.

## Estandar para archivos `.s`

Ambos modulos siguen cabecera completa, registros usados y comentarios por bloque/linea.

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

Debe terminar con `exit(0)` validando `(4+6)*3 = 30`.

## Verificacion (checklist)

- Se ensamblan y enlazan ambos `.s`.
- `sum2` retorna suma correcta.
- `combine_and_scale` preserva/restaura `x19`.

## Errores comunes

- Olvidar `.global` en funcion exportada.
- No preservar callee-saved en funcion no-leaf.
- Romper el balance del stack.

## Ejercicios propuestos

1. Cambia argumentos y valida nuevo resultado.
2. Agrega `diff2` en modulo auxiliar.
3. Agrega tercera llamada encadenada y verifica ABI.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultado final correcto.
- **ABI:** preservacion de registros correcta.
- **Modularidad:** separacion clara entre archivos.

## Proxima leccion

- [Leccion 12 - Tipos y extension de signo/cero](../12_tipos_y_extension_signo_cero/README.md)
