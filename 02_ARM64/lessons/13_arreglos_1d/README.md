# Leccion 13 - Arreglos 1D

## Objetivo de aprendizaje

Modelar arreglos lineales en memoria y aplicar operaciones de alto nivel (lectura, reemplazo, insercion, eliminacion, busqueda) en ARM64.

## Prerrequisitos

- Haber completado `../12_tipos_y_extension_signo_cero/README.md`.
- Entender base+offset y tamano de dato.

## Conceptos nuevos (3-5 maximo)

- Indexado lineal: `addr = base + i * elem_size`.
- Operaciones de arreglo numerico.
- Operaciones de arreglo texto (ASCII).

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `ldr/str` por indice | Lee/escribe elemento | Base, indice, offset | Reemplazar datos |
| `add/sub` en loops | Mueve datos por corrimiento | Contador y limites | Insertar/eliminar |
| `cmp` + branches | Controla busqueda/limites | Valores y flags | Validar posicion/capacidad |
| `ldrb/strb` | Maneja texto byte a byte | Buffer ASCII | Operaciones en cadenas |

## Archivos de la leccion

```text
lessons/13_arreglos_1d/
|- README.md
|- main.s                (pendiente)
|- array_int_examples.s  (pendiente)
|- array_text_examples.s (pendiente)
`- Makefile              (pendiente)
```

## Estado actual

Leccion planificada para siguiente iteracion de implementacion.

## Estandar para archivos `.s`

Cuando se implemente, `main.s` y modulos auxiliares deben seguir el formato canonico del curso: cabecera completa, registros usados, secciones de datos/codigo y comentarios linea por linea en instrucciones clave.

## Flujo de trabajo

Cuando la leccion este implementada:

```bash
make
make run
make gdb
```

## Salida esperada

Mostrara menu de operaciones sobre arreglos numericos y texto.

## Verificacion (checklist)

- Reemplazo por indice correcto.
- Insercion/desplazamiento sin perder datos.
- Eliminacion con corrimiento correcto.
- Busqueda retorna posicion correcta.

## Errores comunes

- Off-by-one en limites.
- Desbordar capacidad del arreglo.
- Confundir bytes de texto con enteros de 32/64 bits.

## Ejercicios propuestos

1. Insertar elemento en posicion intermedia.
2. Eliminar primera y ultima posicion.
3. Buscar caracter en string y retornar indice.

## Criterios de evaluacion sugeridos

- **Correctitud:** operaciones mantienen integridad del arreglo.
- **Direccionamiento:** offsets correctos segun tipo.
- **Depuracion:** trazas claras de corrimientos.

## Proxima leccion

- [Leccion 14 - Matrices indexado 2D](../14_matrices_indexado_2d/README.md)
