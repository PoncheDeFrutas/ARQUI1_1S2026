# Leccion XX - Titulo de la leccion

## Objetivo de aprendizaje

Describe en 2-4 lineas que habilidad concreta debe lograr el estudiante al finalizar.

## Prerrequisitos

- Leccion(es) previa(s) requerida(s).
- Conceptos necesarios (ej. registros, saltos, memoria, ABI).
- Herramientas minimas (`make`, `gdb`, `qemu-riscv64`).

## Conceptos nuevos (3-5 maximo)

- Concepto 1
- Concepto 2
- Concepto 3

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `instruccion_1` | Accion principal | Registros/datos requeridos | Uso practico en la leccion |
| `instruccion_2` | Accion principal | Registros/datos requeridos | Uso practico en la leccion |
| `instruccion_3` | Accion principal | Registros/datos requeridos | Uso practico en la leccion |

Opcional: agrega "otras instrucciones relacionadas" para extender practica.

## Archivos de la leccion

```text
lessons/XX_nombre_leccion/
|- README.md
|- main.s
`- Makefile
```

Si hay multiarchivo, agrega aqui los modulos (`algo.s`, `utils.s`, etc.) y el rol de cada uno.

## Estandar para archivos `.s`

Cada archivo ensamblador debe seguir este formato minimo:

- Cabecera de bloque con nombre de leccion, archivo, toolchain y objetivo.
- Bloque inicial "Registros usados" indicando registro y rol.
- Separador de `Seccion de datos` (aunque no se use, indicar que no aplica).
- Separador de `Seccion de codigo`.
- Bloques comentados por pasos.
- Comentarios en lineas clave (`li`, `la`, `jal`, `ecall`) con efecto en registros.

Base de estilo: `../00_hello_world_syscalls/main.s`.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

Incluye una salida minima verificable:

```text
<salida esperada>
```

## Verificacion (checklist)

- El binario `build/main` se genera sin error.
- `make run` produce la salida esperada.
- En depuracion se observan los registros esperados.
- La logica principal funciona con al menos 2 casos de prueba.

## Errores comunes

- Error 1 y como detectarlo.
- Error 2 y como corregirlo.
- Error 3 y como evitarlo en futuras lecciones.

## Ejercicios propuestos

1. Ejercicio base (aplicar concepto principal).
2. Ejercicio intermedio (caso borde o variante).
3. Ejercicio reto (extension de la leccion).

## Criterios de evaluacion sugeridos

- **Correctitud:** resultados correctos en casos base y borde.
- **Disciplina de ABI/memoria:** uso correcto de registros, stack y convenciones.
- **Depuracion:** evidencia de analisis con GDB.

## Proxima leccion

- Nombre y objetivo breve de la siguiente leccion.
