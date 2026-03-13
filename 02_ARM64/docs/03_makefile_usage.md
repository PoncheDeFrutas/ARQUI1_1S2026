# Uso de Makefiles en las lecciones ARM64

Este documento define como usar y mantener Makefiles en la seccion ARM64.

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
- `tools/makefile-templates/Makefile.arm64.single`
- `tools/makefile-templates/Makefile.arm64.multi`

## Como elegir plantilla

- Leccion de un solo archivo (`main.s`) -> variante `single`.
- Leccion con varios modulos (`main.s`, `*.s`) -> variante `multi`.
- Host ARM64 (Raspberry Pi) -> plantilla `arm64.*`.
- Host x86_64 con emulacion -> plantilla `qemu.*`.

## Buenas practicas de mantenimiento

- Mantener nombres de target iguales en todas las lecciones.
- Evitar logica especial por leccion salvo que sea estrictamente didactica.
- Incluir `-g` para facilitar depuracion.
- No hardcodear rutas absolutas.

## Checklist para una nueva leccion

- `make` genera `build/main`.
- `make run` ejecuta sin cambios en fuentes.
- `make gdb` funciona en el flujo definido por la leccion.
- `make clean` elimina `build/`.

## Documento historico

La version extensa anterior con comparativas detalladas permanece en `makefiles-arm64-variants.md` como referencia de compatibilidad.
