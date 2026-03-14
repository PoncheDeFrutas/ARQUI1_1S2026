# Leccion 07 - ALU matematica basica

## Objetivo de aprendizaje

Practicar operaciones matematicas de ALU (`add`, `sub`, `mul`) y validar resultados por ramas de control.

## Prerrequisitos

- Haber completado `../06_loops_while_for/README.md`.
- Entender registros y comparaciones.

## Conceptos nuevos (3-5 maximo)

- Operaciones de ALU matematica.
- Validacion por multiples comparaciones.
- Menu para seleccionar demo.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `add` | Suma dos operandos | Registros fuente y destino | Aritmetica basica |
| `sub` | Resta operandos | Registros fuente y destino | Diferencias |
| `mul` | Multiplica operandos | Registros fuente y destino | Producto |
| `cmp` + `b.ne` | Verifica resultado | Valor esperado | Validacion de demo |

## Archivos de la leccion

```text
lessons/07_alu_matematica_basica/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` incluye menu y dos demos: `demo_add_sub` y `demo_mul`.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) add/sub
2) mul
Seleccion (1-2):
```

Cada opcion debe terminar en `exit(0)`.

## Verificacion (checklist)

- Opcion 1 valida `9+4=13` y `9-4=5`.
- Opcion 2 valida `6*7=42`.
- Rama de error no se activa en caso correcto.

## Errores comunes

- Comparar contra constante incorrecta.
- Olvidar reiniciar registros entre demos.
- Usar branch de error en etiqueta equivocada.

## Ejercicios propuestos

1. Agrega demo de division entera (si decides introducir `udiv`).
2. Agrega demo de negacion con `sub` desde cero.
3. Permite seleccionar nuevos operandos fijos por opcion.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultados matematicos correctos.
- **Uso de ALU:** instrucciones bien aplicadas.
- **Depuracion:** inspeccion de resultados intermedios.

## Proxima leccion

- [Leccion 08 - ALU logica y bits](../08_alu_logica_y_bits/README.md)
