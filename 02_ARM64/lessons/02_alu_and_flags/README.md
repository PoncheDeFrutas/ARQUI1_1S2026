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
- Banderas de condicion (enfasis en `Z`).
- Salto condicional con `b.eq`.

## Archivos de la leccion

```text
lessons/02_alu_and_flags/
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

El programa no imprime texto y finaliza con codigo `0` si la validacion es correcta.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `make run` finaliza correctamente.
- En GDB puedes observar `x3 = 19` y bandera `Z = 1` tras `cmp x3, #19`.
- Si cambias el valor esperado, el flujo entra a la rama de error.

## Errores comunes

- Confundir `cmp` con una resta que guarda resultado en registro.
- Usar condicion de salto equivocada (`b.ne` en lugar de `b.eq`).
- Sobrescribir registros de trabajo antes de la comparacion.

## Ejercicios propuestos

1. Cambia los operandos y ajusta la constante esperada.
2. Agrega una segunda validacion usando `sub` y otra rama condicional.
3. Haz que el programa retorne `2` en la rama de error para distinguir fallos.

## Criterios de evaluacion sugeridos

- **Correctitud:** la rama condicional coincide con el resultado esperado.
- **Lectura de flags:** identifica cuando `Z` vale 0 o 1.
- **Depuracion:** demuestra paso a paso la decision del branch.

## Proxima leccion

- [Leccion 03 - Branches y loops](../03_branches_and_loops/README.md)
