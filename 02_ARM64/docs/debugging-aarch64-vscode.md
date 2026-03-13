# Depuracion ARM64 (AArch64) con VS Code: entornos nativo ARM y host x86 y x64 + QEMU

Archivo mantenido por compatibilidad con enlaces anteriores.

La guia activa esta en [02_debugging.md](02_debugging.md), incluyendo seccion explicita de como editar `launch.json` segun el host.

## Cambio clave en `launch.json`

- **Nativo ARM64:** `miDebuggerPath` = `/usr/bin/gdb` y sin `miDebuggerServerAddress`.
- **x86 y x64 + QEMU:** `miDebuggerPath` = `/usr/bin/gdb-multiarch` y `miDebuggerServerAddress` = `localhost:1234`.

## Recomendacion practica

Usa directamente las dos configuraciones ya incluidas en `02_ARM64/.vscode/launch.json`:

- `Debug ARM64 (nativo)`
- `Debug ARM64 (QEMU)`

Solo selecciona la correcta al depurar. Si agregas lecciones nuevas, recuerda actualizar `inputs.options`.
