# Leccion 09 - Memoria load/store basico

## Objetivo de aprendizaje

Entender acceso a memoria con `adr`, `ldr`, `str` y offsets en un bloque de datos de 64 bits.

## Prerrequisitos

- Haber completado `../08_alu_logica_y_bits/README.md`.
- Entender operaciones de registros.

## Conceptos nuevos (3-5 maximo)

- Direccion base + offset.
- Carga y almacenamiento de `.quad`.
- Validacion de resultado releido desde memoria.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `adr xD, label` | Carga direccion de etiqueta | Simbolo de datos | Obtener base del bloque |
| `ldr xD, [base,#off]` | Lee 64 bits | Base valida y offset | Cargar variables |
| `str xD, [base,#off]` | Escribe 64 bits | Base valida y dato | Guardar resultados |
| `cmp` + `b.ne` | Compara con esperado | Resultado y constante | Verificar correctitud |

## Archivos de la leccion

```text
lessons/09_memoria_load_store_basico/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` incluye layout de datos (`a`,`b`,`r`) y comentarios de offsets (`0`,`8`,`16`).

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

Debe terminar con `exit(0)`.

## Verificacion (checklist)

- `x1=10`, `x2=20`, `x3=30` durante ejecucion.
- `r` en memoria queda en `30`.
- Validacion final retorna exito.

## Errores comunes

- Usar offsets incorrectos.
- Sobrescribir base de datos (`x10`).
- Cargar direccion cuando se queria valor (o viceversa).

## Ejercicios propuestos

1. Agrega variable extra y almacena resta.
2. Cambia datos iniciales y valida nuevo resultado.
3. Usa `ldrb`/`strb` en un ejemplo complementario.

## Criterios de evaluacion sugeridos

- **Correctitud:** lectura/escritura correcta.
- **Direccionamiento:** base+offset coherente.
- **Depuracion:** inspeccion de memoria y registros.

## Proxima leccion

- [Leccion 10 - Stack y funciones](../10_stack_y_funciones/README.md)
