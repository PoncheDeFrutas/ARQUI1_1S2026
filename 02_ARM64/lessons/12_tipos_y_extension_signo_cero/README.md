# Leccion 12 - Tipos y extension de signo/cero

## Objetivo de aprendizaje

Distinguir zero extension y sign extension al cargar bytes en ARM64, y entender el impacto de tipos signed/unsigned.

## Prerrequisitos

- Haber completado `../11_abi_y_multiarchivo/README.md`.
- Entender manejo basico de memoria y registros.

## Conceptos nuevos (3-5 maximo)

- `ldrb` (zero extension).
- `ldrsb` (sign extension).
- Diferencia semantica entre `0xF2` unsigned y signed.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `ldrb wD, [addr]` | Carga byte y extiende con ceros | Direccion valida | Interpretar unsigned |
| `ldrsb xD, [addr]` | Carga byte y extiende signo | Direccion valida | Interpretar signed |
| `cmp` + `b.ne` | Valida valor esperado | Resultado y constante | Verificar extension |
| `read`/`write` | Menu de demos | Syscalls y buffer | Elegir caso |

## Archivos de la leccion

```text
lessons/12_tipos_y_extension_signo_cero/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` contiene menu con dos demos y comentarios por instruccion critica.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) ldrb zero extension
2) ldrsb sign extension
Seleccion (1-2):
```

Cada opcion debe terminar con `exit(0)`.

## Verificacion (checklist)

- Opcion 1 valida `x1 = 0xF2` sin signo.
- Opcion 2 valida `x1 = -14` con signo.
- Rama de error se activa solo en casos alterados.

## Errores comunes

- Usar `ldrb` cuando se necesita signo.
- Comparar signed con constante unsigned.
- Olvidar que `0xF2` puede significar 242 o -14 segun tipo.

## Ejercicios propuestos

1. Agrega demo con `ldrh` y `ldrsh`.
2. Cambia byte de prueba a `0x80` y analiza ambos casos.
3. Agrega validacion hexadecimal en comentarios de depuracion.

## Criterios de evaluacion sugeridos

- **Correctitud:** extensiones de tipo correctas.
- **Interpretacion:** diferencia clara signed/unsigned.
- **Depuracion:** lectura de registros extendidos.

## Proxima leccion

- [Leccion 13 - Arreglos 1D](../13_arreglos_1d/README.md)
