# Leccion 00 - Hello World y syscalls

## Objetivo de aprendizaje

Construir y ejecutar el primer programa ARM64 en Linux sin libc, usando syscalls directas para imprimir un mensaje y finalizar el proceso.

## Prerrequisitos

- Entorno configurado segun `../../docs/01_setup_and_workflows.md`.
- Conocer comandos basicos de terminal.
- Tener disponible `make` y toolchain ARM64.

## Conceptos nuevos (3-5 maximo)

- Punto de entrada `_start`.
- Convencion de syscalls en ARM64 (`x0-x5`, `x8`, `svc #0`).
- Secciones `.data` y `.text`.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `mov` | Carga valores inmediatos | Registro destino e inmediato | Preparar argumentos de syscall |
| `adr` | Carga direccion de etiqueta | Etiqueta valida | Apuntar al mensaje en memoria |
| `svc #0` | Invoca al kernel | Numero en `x8` y args en `x0-x5` | Ejecutar syscall |
| `write` (`x8=64`) | Escribe bytes en stdout | `x0=1`, `x1=buffer`, `x2=len` | Mostrar texto |
| `exit` (`x8=93`) | Termina proceso | `x0=codigo` | Finalizar programa |

## Archivos de la leccion

```text
lessons/00_hello_world_syscalls/
|- README.md
|- main.s
`- Makefile
```

## Estandar para archivos `.s`

`main.s` usa el formato base del curso: cabecera, registros usados, seccion de datos/codigo y comentarios linea por linea en instrucciones clave.

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

```text
Hello, world
```

## Verificacion (checklist)

- `build/main` se genera sin error.
- `make run` imprime `Hello, world`.
- En depuracion puedes detenerte en `_start`.
- Identificas uso de `x0`, `x1`, `x2`, `x8`.

## Errores comunes

- Olvidar `_start` como simbolo global.
- Usar numero de syscall incorrecto.
- No actualizar longitud del mensaje al cambiar texto.

## Ejercicios propuestos

1. Cambia el mensaje impreso.
2. Imprime dos lineas con dos syscalls `write`.
3. Retorna `exit(2)` y verifica el codigo en shell.

## Criterios de evaluacion sugeridos

- **Correctitud:** imprime y finaliza correctamente.
- **Disciplina de registros:** argumentos en registros correctos.
- **Depuracion:** inspeccion de registros en `_start`.

## Proxima leccion

- [Leccion 01 - Registros y mov](../01_registros_y_mov/README.md)
