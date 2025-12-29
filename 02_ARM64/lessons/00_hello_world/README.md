# Lección 00 – Hello World en ARM64 (Linux)

## Objetivo de la lección

En esta primera lección aprenderás a ejecutar tu **primer programa en ensamblador AArch64 (ARM64)** sobre Linux, **sin usar gcc**, utilizando únicamente:

* `as` (ensamblador)
* `ld` (enlazador)
* `qemu-aarch64` (emulación)

El programa mostrará el texto **"Hello, world"** en pantalla usando **syscalls de Linux**, y luego finalizará correctamente.

---

## Qué aprenderás

Al finalizar esta lección serás capaz de:

* Entender el punto de entrada `_start` en programas ARM64
* Usar syscalls en Linux AArch64
* Comprender el rol de los registros principales en syscalls
* Ensamblar, enlazar y ejecutar un binario ARM64
* Ver el resultado usando QEMU

---

## Conceptos clave introducidos

### 1. Punto de entrada: `_start`

En programas sin libc, **`_start` es el punto de entrada real** del programa. Linux comienza la ejecución aquí, no en `main`.

### 2. Syscalls en ARM64 Linux

Las llamadas al sistema permiten interactuar con el kernel (escribir en pantalla, salir del programa, etc.).

En ARM64:

* El **número de syscall** se coloca en el registro `x8`
* Los **argumentos** se pasan en `x0`–`x5`
* La instrucción `svc #0` invoca al kernel

---

## Syscalls utilizadas en esta lección

### `write`

Permite escribir datos en un descriptor de archivo.

| Registro | Contenido                    |
| -------- | ---------------------------- |
| `x0`     | File descriptor (1 = stdout) |
| `x1`     | Dirección del buffer         |
| `x2`     | Número de bytes a escribir   |
| `x8`     | Número de syscall (`64`)     |

### `exit`

Finaliza el programa.

| Registro | Contenido                |
| -------- | ------------------------ |
| `x0`     | Código de salida         |
| `x8`     | Número de syscall (`93`) |

---

## Archivos de esta lección

```
lessons/00-hello-world/
├── README.md
├── main.s
└── Makefile
```

* `main.s`: código ensamblador ARM64
* `Makefile`: automatiza ensamblado, enlace y ejecución

---

## Cómo construir el programa

Desde el directorio de la lección:

```bash
make
```

Esto ejecuta:

1. Ensamblado con `aarch64-linux-gnu-as`
2. Enlace con `aarch64-linux-gnu-ld`

---

## Cómo ejecutar el programa

```bash
make run
```

Salida esperada:

```text
Hello, world
```

---

## (Opcional) Ejecutar en modo depuración

Para ejecutar el programa bajo QEMU con soporte para GDB:

```bash
make debug
```

Esto dejará el programa detenido esperando que GDB se conecte.

---

## Qué observar en el código

Al revisar `main.s`, presta atención a:

* Uso de `.data` para almacenar el mensaje
* Uso de `.text` para el código
* Carga de direcciones con `adr`
* Uso explícito de registros `x0`, `x1`, `x2`, `x8`
* La instrucción `svc #0`

No te preocupes si aún no entiendes cada instrucción: **las siguientes lecciones profundizarán en cada concepto**.

---

## Errores comunes

* Olvidar definir `_start`
* Usar números de syscall incorrectos
* Confundir registros `x` con `w`
* Esperar que exista `main`

---

## Próxima lección

**Lección 01 – Registros en ARM64**

Exploraremos:

* Registros `x0–x30`
* Diferencia entre `xN` y `wN`
* Convenciones básicas de uso

---

## Nota educativa

Este proyecto está diseñado con fines **educativos**.

Todo el código:

* Es explícito
* Evita dependencias innecesarias
* Prioriza claridad sobre optimización

Si vienes de x86_64 o de lenguajes de alto nivel, tómate tu tiempo: ARM64 tiene un diseño limpio y coherente que vale la pena aprender desde la base.

---

Cuando estés listo, continúa con la siguiente lección.
