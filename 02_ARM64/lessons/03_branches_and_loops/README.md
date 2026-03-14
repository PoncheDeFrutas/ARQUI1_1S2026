# Leccion 03 - Branches y loops

## Objetivo de aprendizaje

Construir un ciclo controlado por comparaciones y saltos condicionales para acumular resultados en registros.

## Prerrequisitos

- Haber completado `../02_alu_and_flags/README.md`.
- Entender `cmp`, `b.eq` y codigo de salida por syscall `exit`.
- Entorno de depuracion disponible.

## Conceptos nuevos (3-5 maximo)

- Branches incondicionales y condicionales (`b`, `b.gt`, `b.ne`).
- Estructuras tipo `for`, `while` y `do-while`.
- Contador y acumulador en registros.
- Validacion de resultado por cada demo.

## Instrucciones y operaciones de esta leccion

### Nucleo usado en los ejemplos

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `cmp rn, rm|#imm` | Compara y actualiza flags | Operando izquierdo y derecho | Condicion de continuidad/salida del loop |
| `b etiqueta` | Salto incondicional | Etiqueta destino | Volver al inicio del ciclo |
| `b.gt etiqueta` | Salto signed "mayor que" | Flags de `cmp` | Cerrar `for` y `while` al pasar limite |
| `b.ne etiqueta` | Salto si distinto | `Z = 0` | Repetir en `do-while` |
| `add rd, rn, #imm` | Incrementa valor | Registro fuente/destino + inmediato | Avance de contador o acumulador |
| `sub rd, rn, #imm` | Decrementa valor | Registro fuente/destino + inmediato | Countdown o control descendente |

### Como se traduce cada estructura

- `for`: inicializacion -> condicion -> cuerpo -> incremento -> salto al chequeo.
- `while`: chequeo inicial -> cuerpo -> salto al chequeo.
- `do-while`: cuerpo primero -> chequeo al final -> posible repeticion.

### Otras variantes utiles para practicar

- Condiciones unsigned: `b.lo`, `b.hs`, `b.hi`, `b.ls`.
- Condiciones signed adicionales: `b.ge`, `b.le`.
- Saltos por cero/no cero en registro: `cbz`, `cbnz`.

## Archivos de la leccion

```text
lessons/03_branches_and_loops/
|- README.md
|- main.s
|- loop_examples.s
`- Makefile
```

`main.s` contiene el menu y seleccion de demo.
`loop_examples.s` contiene las implementaciones de loops.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

Para ejecutar una demo especifica desde terminal:

```bash
printf "1\n" | make run   # for: suma 1..5
printf "2\n" | make run   # while: suma pares 2..10
printf "3\n" | make run   # do-while: countdown 5..1
```

## Salida esperada

El programa muestra un menu y ejecuta la demo seleccionada. Si el resultado de la demo es correcto, termina con codigo `0`.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `printf "1\n" | make run` valida el caso estilo `for`.
- `printf "2\n" | make run` valida el caso estilo `while`.
- `printf "3\n" | make run` valida el caso estilo `do-while`.
- En GDB observas contador/acumulador y condicion de salida en cada loop.

## Errores comunes

- Inicializar mal contador o acumulador.
- Usar condicion incorrecta del loop (`b.lt`, `b.ge`, etc.).
- Olvidar incrementar el contador y quedar en loop infinito.
- No separar la logica por demos y mezclar registros sin plan.

## Ejercicios propuestos

1. Agrega una demo para calcular factorial con loop.
2. Implementa una demo que cuente cuantos valores son mayores a un umbral.
3. Agrega salida por `write` para mostrar que demo se ejecuto.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultado final correcto para el rango definido.
- **Control de flujo:** loop termina cuando corresponde.
- **Depuracion:** evidencia de analisis de contador y acumulador.

## Proxima leccion

- [Leccion 04 - Memoria, load y store](../04_memory_load_store/README.md)
