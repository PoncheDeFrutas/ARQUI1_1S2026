# Leccion 13 - Arreglos 1D

## Objetivo de aprendizaje

Representar arreglos lineales en memoria ARM64 y acceder a sus elementos usando direccionamiento base+offset. Al finalizar, el estudiante debe poder leer, reemplazar y buscar elementos en un arreglo numerico, y recorrer texto ASCII byte a byte.

## Prerrequisitos

- Haber completado `../12_tipos_y_extension_signo_cero/README.md`.
- Entender `adr`, `ldr`, `str`, `ldrb` y `cmp`.
- Entender que el tamano del dato afecta el offset.

## Conceptos nuevos (3-5 maximo)

- Indexado lineal: `addr = base + i * elem_size`.
- Diferencia entre arreglo de `.quad` y string ASCII.
- Busqueda lineal con loop y comparaciones.
- Uso de `lsl #3` para multiplicar un indice por 8.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `adr xD, label` | Carga direccion base del arreglo | Etiqueta valida | Obtener base de datos |
| `ldr/str` con offset calculado | Lee o escribe un `.quad` | Base y offset en bytes | Acceso por indice a enteros |
| `ldrb` | Lee un byte ASCII | Base de string e indice | Recorrer texto caracter por caracter |
| `lsl #3` | Multiplica indice por 8 | Indice entero | Calcular offset para `quad` |
| `cmp` + branches | Controla busqueda y validacion | Valores y flags | Verificar resultados y limites |

## Archivos de la leccion

```text
lessons/13_arreglos_1d/
|- README.md
|- main.s
|- array_int_examples.s
|- array_text_examples.s
`- Makefile
```

- `main.s`: muestra menu y llama la demo elegida.
- `array_int_examples.s`: demos con arreglos de enteros.
- `array_text_examples.s`: demo con texto ASCII.

## Estandar para archivos `.s`

Todos los archivos siguen el formato canonico del curso: cabecera, registros usados, seccion de datos, seccion de codigo y comentarios por bloque en cada instruccion critica.

## Como pensar un arreglo 1D en ARM64

Un arreglo no es mas que una zona continua de memoria.

Si el arreglo contiene enteros de 64 bits:

- cada elemento ocupa 8 bytes;
- `arr[0]` esta en `base + 0`;
- `arr[1]` esta en `base + 8`;
- `arr[2]` esta en `base + 16`.

Por eso la formula general es:

```text
direccion = base + indice * tamano_elemento
```

En esta leccion:

- para enteros `.quad`, `tamano_elemento = 8`;
- para texto ASCII, `tamano_elemento = 1`.

## Demos incluidas

1. Leer `arr[2]` de un arreglo numerico y validar que vale `9`.
2. Reemplazar `arr[1]` por `99` y releerlo desde memoria.
3. Buscar `15` en un arreglo y verificar tambien el caso no encontrado con `7`.
4. Recorrer la palabra `banana` y contar cuantas veces aparece `'a'`.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

```text
1) leer arr[2]
2) reemplazar arr[1]
3) buscar valor
4) contar 'a' en banana
Seleccion (1-4):
```

Cada opcion valida internamente el resultado y termina con `exit(0)` si todo esta correcto.

## Verificacion (checklist)

- Opcion 1 calcula `base + 2*8` y relee `9`.
- Opcion 2 escribe `99` en el segundo elemento sin alterar los vecinos.
- Opcion 3 encuentra `15` en la posicion `2` y retorna no encontrado para `7`.
- Opcion 4 recorre el texto byte a byte y cuenta `3` apariciones de `'a'`.

## Errores comunes

- Olvidar multiplicar el indice por el tamano del dato.
- Tratar un string como si cada elemento ocupara 8 bytes.
- Perder el caso de salida en una busqueda lineal.
- Confundir indice con offset en bytes.

## Ejercicios propuestos

1. Agrega una demo que sume todos los elementos de un arreglo `quad`.
2. Modifica la busqueda para retornar `-1` explicitamente en `x0`.
3. Cuenta otra letra en `banana` y valida el nuevo resultado.

## Criterios de evaluacion sugeridos

- **Correctitud:** cada demo produce el resultado esperado.
- **Direccionamiento:** los offsets usados coinciden con el tamano del elemento.
- **Lectura de memoria:** el estudiante puede explicar por que `arr[i]` cambia de direccion.

## Proxima leccion

- [Leccion 14 - Matrices indexado 2D](../14_matrices_indexado_2d/README.md)
