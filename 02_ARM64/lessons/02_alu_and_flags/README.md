# Leccion 02 - ALU y banderas (flags)

## Objetivo de aprendizaje

Usar operaciones aritmeticas basicas de la ALU y comprender como `cmp` actualiza banderas para tomar decisiones con saltos condicionales.

## Prerrequisitos

- Haber completado `../01_registers_and_mov/README.md`.
- Entender registros `xN` y uso de inmediatos con `mov`.
- Entorno de build funcionando (`make`, `make run`, `make gdb`).

## Conceptos nuevos (3-5 maximo)

- Operaciones `add` y `sub`.
- Comparacion con `cmp`.
- Banderas de condicion (`Z`, comparacion signed con `N/V`).
- Operaciones logicas `and` y `tst`.
- Saltos condicionales `b.eq`, `b.ne`, `b.lt`.

## Instrucciones y operaciones de esta leccion

### Nucleo usado en los ejemplos

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `add rd, rn, rm|#imm` | Suma operandos | 2 operandos + registro destino | Acumulacion y aritmetica basica |
| `sub rd, rn, rm|#imm` | Resta operandos | 2 operandos + registro destino | Diferencias, decrementos, rangos |
| `and rd, rn, rm` | AND bit a bit | 2 registros fuente + destino | Mascaras de bits |
| `cmp rn, rm|#imm` | Compara sin guardar resultado | Registro + operando para comparacion | Actualizar flags para branches |
| `tst rn, rm` | Prueba bits comunes | 2 registros | Verificar bits activos via flags |
| `b.eq etiqueta` | Salta si igual | `Z = 1` tras `cmp/tst` | Rama de exito/igualdad |
| `b.ne etiqueta` | Salta si distinto | `Z = 0` tras `cmp/tst` | Rama alternativa/condicion no cumplida |
| `b.lt etiqueta` | Salta si menor (signed) | Flags `N` y `V` | Comparaciones con signo |

### Otras operaciones ALU recomendadas para practicar

- `orr`, `eor`, `bic`: operaciones logicas adicionales.
- `lsl`, `lsr`, `asr`: desplazamientos para escalar o extraer campos.
- `adc`, `sbc`: suma/resta con acarreo en rutinas multi-precision.
- `cmn`: compara por suma (actualiza flags sin guardar resultado).

## Archivos de la leccion

```text
lessons/02_alu_and_flags/
|- README.md
|- main.s
|- alu_examples.s
`- Makefile
```

`main.s` contiene el menu y seleccion de demo.
`alu_examples.s` contiene las rutinas de ALU y banderas.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

Para ejecutar una demo especifica desde terminal:

```bash
printf "1\n" | make run   # add/sub + cmp + b.eq
printf "2\n" | make run   # and/tst + b.ne
printf "3\n" | make run   # cmp firmado + b.lt
```

## Salida esperada

El programa muestra un menu y ejecuta la demo seleccionada. Si la demo valida correctamente, termina con codigo `0`.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `printf "1\n" | make run` finaliza con codigo `0`.
- `printf "2\n" | make run` usa operacion logica y branch por `Z`.
- `printf "3\n" | make run` valida comparacion signed con `b.lt`.
- En GDB puedes ver como cambian flags tras `cmp` y `tst`.

## Errores comunes

- Confundir `cmp` con una resta que guarda resultado en registro.
- Usar condicion de salto equivocada para signed/unsigned.
- Sobrescribir registros de trabajo antes de la comparacion.
- No considerar que Enter envia `\n` y solo se evalua el primer byte.

## Ejercicios propuestos

1. Agrega una demo 4 para `eor` y valida resultado.
2. Crea una comparacion unsigned con `b.lo` o `b.hs`.
3. Imprime un mensaje corto de exito o error segun la opcion.

## Criterios de evaluacion sugeridos

- **Correctitud:** la rama condicional coincide con el resultado esperado.
- **Lectura de flags:** identifica cuando `Z` vale 0 o 1.
- **Depuracion:** demuestra paso a paso la decision del branch.

## Proxima leccion

- [Leccion 03 - Branches y loops](../03_branches_and_loops/README.md)
