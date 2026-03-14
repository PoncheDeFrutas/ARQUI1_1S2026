# Leccion 04 - Memoria, load y store

## Objetivo de aprendizaje

Introducir acceso a memoria en ARM64 con `ldr` y `str`, diferenciando entre trabajo en registros y datos almacenados en seccion `.data`.

## Prerrequisitos

- Haber completado `../03_branches_and_loops/README.md`.
- Entender operaciones en registros y branches.
- Entorno de depuracion disponible para inspeccionar memoria.

## Conceptos nuevos (3-5 maximo)

- Seccion `.data` para variables inicializadas.
- Carga de direccion base con `adr`.
- Lectura y escritura en memoria con `ldr` y `str`.
- Validacion de resultados leidos desde memoria.

## Instrucciones y operaciones de esta leccion

### Nucleo usado en los ejemplos

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `adr xd, label` | Carga direccion de etiqueta | Simbolo valido en el ensamblado | Obtener base del bloque de datos |
| `ldr xd, [base, #offset]` | Lee 64 bits desde memoria | Base valida + offset correcto | Cargar variables al registro |
| `str xd, [base, #offset]` | Escribe 64 bits a memoria | Base valida + offset + dato en registro | Guardar resultados calculados |
| `add xd, xn, xm|#imm` | Opera con datos en registros | Operandos cargados previamente | Procesar valores leidos |
| `cmp` + `b.eq` | Compara y salta si coincide | Resultado esperado y flags | Verificar correctitud de la rutina |

### Que necesita cada acceso a memoria

- **Base:** puntero al inicio del bloque (en esta leccion, `x10 = &a`).
- **Offset:** desplazamiento en bytes dentro del bloque.
- **Tamano de dato:** define la instruccion (`ldr/str` para 64 bits).

### Variantes para ampliar practica

- `ldrb/strb` para 8 bits.
- `ldrh/strh` para 16 bits.
- `ldr wN/str wN` para 32 bits.
- Modo post-index o pre-index para recorrer buffers.

## Vista visual de memoria en esta leccion

En `main.s` se definen tres variables `.quad` consecutivas:

```text
Direccion base (a) = X

X + 0   -> a      (8 bytes)
X + 8   -> b      (8 bytes)
X + 16  -> result (8 bytes)
```

Por eso el codigo usa:

- `ldr x1, [x10, #0]` para leer `a`
- `ldr x2, [x10, #8]` para leer `b`
- `str x3, [x10, #16]` para guardar `result`

Regla: como son datos de 64 bits (`.quad`), cada offset avanza de 8 en 8.

## Archivos de la leccion

```text
lessons/04_memory_load_store/
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

El programa no imprime texto y finaliza con codigo `0` cuando el resultado guardado en memoria coincide con lo esperado.

## Verificacion (checklist)

- `build/main` se genera sin error.
- En GDB puedes inspeccionar `a`, `b` y `result` en memoria.
- Tras ejecutar las instrucciones de store, `result` vale `30`.
- El programa termina con `exit(0)` si la comparacion es correcta.

Comandos utiles en GDB para ver el ejemplo de forma visual:

```gdb
break _start
run
si
info registers x10
x/3gx $x10
```

`x/3gx $x10` muestra 3 valores de 64 bits desde la direccion base.

## Errores comunes

- Cargar valor cuando en realidad querias cargar direccion.
- Usar offset incorrecto al acceder a variables consecutivas.
- Sobrescribir la direccion base accidentalmente.
- Asumir que todos los tipos avanzan 8 bytes (solo aplica a `.quad`).

## Ejercicios propuestos

1. Cambia `a` y `b` y verifica nuevo resultado esperado.
2. Agrega una resta y guarda su resultado en otra variable.
3. Implementa un contador en memoria que incremente en loop.

## Criterios de evaluacion sugeridos

- **Correctitud:** lectura/escritura de memoria correcta.
- **Direccionamiento:** uso correcto de base + offset.
- **Depuracion:** verificacion de contenido en memoria.

## Proxima leccion

- Leccion 05 - Stack y funciones.
