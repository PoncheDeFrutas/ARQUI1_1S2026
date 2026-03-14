# Leccion 08 - ALU logica y bits

## Objetivo de aprendizaje

Aplicar operaciones logicas bit a bit y desplazamientos para entender manipulacion de bits en ARM64.

## Prerrequisitos

- Haber completado `../07_alu_matematica_basica/README.md`.
- Entender validacion por comparacion.

## Conceptos nuevos (3-5 maximo)

- `and`, `orr`, `eor`.
- `lsl`, `lsr`.
- Interpretacion binaria de resultados.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `and` | Interseccion de bits | Dos operandos | Aplicar mascaras |
| `orr` | Union de bits | Dos operandos | Activar bits |
| `eor` | XOR bit a bit | Dos operandos | Detectar diferencias |
| `lsl`/`lsr` | Desplaza bits | Valor y cantidad | Escalar y extraer campos |

## Archivos de la leccion

```text
lessons/08_alu_logica_y_bits/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` usa menu con dos demos: logica bit a bit y shifts.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) and/orr/eor
2) shifts
Seleccion (1-2):
```

Cada opcion debe finalizar con `exit(0)`.

## Verificacion (checklist)

- Opcion 1 valida resultados `8`, `14`, `6`.
- Opcion 2 valida `lsl` y `lsr`.
- Se inspeccionan bits en registros durante depuracion.

## Errores comunes

- Confundir `orr` con `eor`.
- Desplazar en direccion equivocada.
- No ajustar valor esperado despues de cambiar operandos.

## Ejercicios propuestos

1. Agrega demo con mascara de nibble bajo.
2. Agrega `asr` para valor signed.
3. Crea demo de activacion/desactivacion de flags por bits.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultados binarios correctos.
- **Manipulacion de bits:** uso adecuado de instrucciones logicas.
- **Depuracion:** verificacion de bits esperados.

## Proxima leccion

- [Leccion 09 - Memoria load/store basico](../09_memoria_load_store_basico/README.md)
