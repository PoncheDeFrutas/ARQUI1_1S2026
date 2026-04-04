# Uso de Makefiles en las lecciones RISC-V

Este documento define como usar y mantener Makefiles en la seccion RISC-V.

## Objetivo

Tener un flujo consistente en todas las lecciones para que el estudiante se concentre en arquitectura y no en variaciones de build.

## Targets estandar

- `make` o `make all`: ensamblar y enlazar.
- `make run`: ejecutar binario.
- `make gdb`: preparar depuracion.
- `make clean`: limpiar artefactos.
- `make info`: ayuda rapida.

## Plantillas disponibles

- `tools/makefile-templates/Makefile.qemu.single`
- `tools/makefile-templates/Makefile.qemu.multi`

## Como elegir plantilla

- Leccion de un solo archivo (`main.s`) -> variante `single`.
- Leccion con varios modulos (`main.s`, `*.s`) -> variante `multi`.
- Flujo oficial de la seccion -> plantilla `qemu.*`.

## Buenas practicas de mantenimiento

- Mantener nombres de target iguales en todas las lecciones.
- Evitar logica especial por leccion salvo que sea estrictamente didactica.
- Incluir `-g` para facilitar depuracion.
- No hardcodear rutas absolutas.

## Checklist para una nueva leccion

- `make` genera `build/main`.
- `make run` ejecuta sin cambios en fuentes.
- `make gdb` funciona con QEMU remoto.
- `make clean` elimina `build/`.

## Nota

Si en el futuro se agrega un flujo nativo RISC-V, las plantillas podran extenderse sin cambiar los targets canonicos de las lecciones.
