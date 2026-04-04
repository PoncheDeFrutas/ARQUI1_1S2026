# Leccion 00 - Hello World y syscalls

## Objetivo de aprendizaje

Construir y ejecutar el primer programa RISC-V 64 en Linux sin libc, usando syscalls directas para imprimir un mensaje y finalizar el proceso.

## Prerrequisitos

- Entorno configurado segun `../../docs/01_setup_and_workflows.md`.
- Conocer comandos basicos de terminal.
- Tener disponible `make` y toolchain RISC-V.

## Conceptos nuevos (3-5 maximo)

- Punto de entrada `_start`.
- Convencion de syscalls en RISC-V (`a0-a5`, `a7`, `ecall`).
- Secciones `.data` y `.text`.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `li` | Carga valores inmediatos | Registro destino e inmediato | Preparar argumentos de syscall |
| `la` | Carga direccion de etiqueta | Etiqueta valida | Apuntar al mensaje en memoria |
| `ecall` | Invoca al kernel | Numero en `a7` y args en `a0-a5` | Ejecutar syscall |
| `write` (`a7=64`) | Escribe bytes en stdout | `a0=1`, `a1=buffer`, `a2=len` | Mostrar texto |
| `exit` (`a7=93`) | Termina proceso | `a0=codigo` | Finalizar programa |

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
- Identificas uso de `a0`, `a1`, `a2`, `a7`.

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

- Pendiente de publicacion: bloque de registros, movimientos y convenciones basicas de RISC-V.
