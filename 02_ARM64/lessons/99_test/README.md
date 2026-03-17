# Leccion 99 - Test visual minimo (ventana + texto)

## Objetivo de aprendizaje

Construir una prueba minima de interfaz grafica en ARM64 puro (ensamblador) sobre Raspberry Pi OS, abriendo una ventana y dibujando un texto con X11.

## Prerrequisitos

- Haber completado `../11_abi_y_multiarchivo/README.md`.
- Ejecutar en Raspberry Pi ARM64 con sesion grafica activa.
- Tener instalados `make`, `as`, `gcc` y `libx11-dev`.

## Conceptos nuevos (3-5 maximo)

- Llamadas a libreria desde ensamblador usando ABI AArch64.
- Bucle de eventos (event loop) basico en X11.
- Dibujo de texto con `XDrawString`.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `bl funcion_x11` | Llama funciones de Xlib | Argumentos en `x0-x7` y stack | Controlar ventana y eventos |
| `stp/ldp` | Guarda/restaura registros | Stack alineado a 16 bytes | Cumplir ABI en `main` |
| `cbz` | Verifica puntero nulo | Registro a validar | Detectar error de `XOpenDisplay` |
| `ldr w0, [sp,#16]` | Lee tipo de evento | Buffer de `XEvent` en stack | Decidir si dibujar o cerrar |

## Archivos de la leccion

```text
lessons/99_test/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` mantiene el formato del curso: cabecera, registros usados, seccion de datos/codigo y bloques por pasos con comentarios en operaciones clave.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
```

Opcional para depuracion:

```bash
make gdb
```

## Salida esperada

Al ejecutar `make run` se abre una ventana titulada `ARM64v8 - Ventana minima` y se dibuja el texto:

```text
Hola desde ARM64 ensamblador
```

Para salir, presiona una tecla con el foco sobre la ventana o cierra la ventana.

## Verificacion (checklist)

- `build/main` se genera sin error.
- `make run` abre ventana grafica en Raspberry Pi OS.
- El texto se dibuja al recibir evento `Expose`.
- El programa cierra limpio con tecla o cierre de ventana.

## Errores comunes

- Ejecutar por SSH sin `DISPLAY` disponible.
- No instalar `libx11-dev` antes de enlazar.
- Romper alineacion de stack al pasar argumentos extra en llamadas de libreria.

## Ejercicios propuestos

1. Cambia titulo y mensaje de la ventana.
2. Dibuja una segunda linea de texto en otra coordenada.
3. Cambia color de borde/fondo usando otros valores en `XCreateSimpleWindow`.

## Criterios de evaluacion sugeridos

- **Correctitud:** abre ventana, dibuja y cierra sin fallas.
- **Disciplina ABI:** argumentos y preservacion de registros correctos.
- **Depuracion:** identifica el evento `Expose` en GDB y traza llamadas X11.

## Proxima leccion

- Extender a entrada de mouse/teclado y redibujado de multiples elementos.
