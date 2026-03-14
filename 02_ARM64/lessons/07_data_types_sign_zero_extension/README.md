# Leccion 07 - Tipos de datos y extension de signo/cero

## Objetivo de aprendizaje

Entender como ARM64 interpreta datos pequenos (8/16/32 bits) al cargarlos en registros de 64 bits, diferenciando **zero extension** y **sign extension**.

## Prerrequisitos

- Haber completado `../06_abi_and_multifile/README.md`.
- Conocer registros `xN` y `wN`.
- Manejar build y depuracion con `make` y `gdb`.

## Conceptos nuevos (3-5 maximo)

- Diferencia entre dato firmado y no firmado.
- `ldrb` (zero extension) vs `ldrsb` (sign extension).
- Efecto de escribir en `wN` sobre `xN`.
- Validacion de resultados en representacion binaria/hexadecimal.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `ldrb wD, [addr]` | Carga byte y extiende con ceros | Direccion valida y registro destino | Leer `uint8` en flujo no firmado |
| `ldrsb xD, [addr]` | Carga byte y extiende signo a 64 bits | Direccion valida y registro destino | Leer `int8` preservando signo |
| `mov wN, #imm` | Escribe 32 bits y limpia parte alta de `xN` | Registro `w` destino e inmediato | Entender relacion `wN`/`xN` |
| `cmp` + `b.eq` | Compara y valida resultado | Operandos correctos y flags | Verificar que la extension esperada ocurra |

## Archivos de la leccion

```text
lessons/07_data_types_sign_zero_extension/
|- README.md
|- main.s
|- type_examples.s
`- Makefile
```

- `main.s`: menu para elegir demo.
- `type_examples.s`: implementa demos de extension.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

Para ejecutar demos especificas:

```bash
printf "1\n" | make run   # zero extension con ldrb
printf "2\n" | make run   # sign extension con ldrsb
printf "3\n" | make run   # escritura en wN y efecto en xN
```

## Ejemplo visual rapido

Dato en memoria:

```text
byte = 0xF2
```

Interpretaciones:

- **Unsigned 8-bit:** `0xF2 = 242`
- **Signed 8-bit:** `0xF2 = -14`

Resultado en 64 bits:

- `ldrb w1, [addr]` -> `x1 = 0x00000000000000F2`
- `ldrsb x1, [addr]` -> `x1 = 0xFFFFFFFFFFFFFFF2`

## Salida esperada

El programa muestra un menu y termina con codigo `0` si la demo seleccionada valida correctamente.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `printf "1\n" | make run` valida zero extension.
- `printf "2\n" | make run` valida sign extension.
- `printf "3\n" | make run` valida limpieza de bits altos al usar `wN`.

Comandos utiles en GDB:

```gdb
break demo_zero_extension
break demo_sign_extension
break demo_w_register_zeroes_upper
run
si
info registers x1 x3 x4
```

## Errores comunes

- Usar `ldrb` cuando se necesita conservar signo.
- Creer que `mov wN, ...` mantiene intacta la parte alta de `xN`.
- Comparar contra valor decimal incorrecto por confundir signed/unsigned.

## Ejercicios propuestos

1. Agrega demo para `ldrsh` (16 bits con signo).
2. Agrega demo para `ldrh` (16 bits sin signo).
3. Usa un valor `0x80` y compara su efecto en `ldrb` vs `ldrsb`.

## Criterios de evaluacion sugeridos

- **Correctitud:** cada demo valida la extension esperada.
- **Interpretacion de datos:** distingue signed y unsigned.
- **Depuracion:** evidencia lectura de registros y valores extendidos.

## Proxima leccion

- Leccion 08 - arreglos 1D.
