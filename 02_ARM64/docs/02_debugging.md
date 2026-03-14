# Depuracion ARM64 (AArch64) con VS Code

Esta guia explica como depurar en los dos escenarios del curso y, sobre todo, como ajustar `launch.json` cuando cambias entre nativo ARM64 y x86_64 + QEMU.

## 1) Antes de depurar: punto clave del workspace

Abre en VS Code la carpeta `02_ARM64/` (no la raiz completa del repo). Asi, `${workspaceFolder}` apunta correctamente a esta ruta y el `launch.json` funciona sin cambiar paths.

Si abres la raiz del repo, ajusta manualmente `program` y `cwd` para incluir `02_ARM64/`.

## 2) Donde se edita

- Archivo: `02_ARM64/.vscode/launch.json`
- El proyecto ya trae dos configuraciones:
  - `Debug ARM64 (nativo)`
  - `Debug ARM64 (QEMU)`

En la mayoria de casos no necesitas crear una configuracion nueva; solo elegir la correcta en VS Code.

## 3) Que cambia entre nativo y QEMU en `launch.json`

### Nativo ARM64 (Raspberry Pi)

- `miDebuggerPath`: `"/usr/bin/gdb"`
- **No** usar `miDebuggerServerAddress`
- `make gdb` abre GDB local

### x86_64 + QEMU

- `miDebuggerPath`: `"/usr/bin/gdb-multiarch"`
- `miDebuggerServerAddress`: `"localhost:1234"`
- Antes de presionar F5 debes ejecutar `make gdb` en otra terminal

## 4) Flujo completo por escenario

### 4.1 Nativo ARM64

```bash
cd lessons/<leccion>
make
make run
make gdb
```

Luego en VS Code:

- Ejecutar configuracion `Debug ARM64 (nativo)`.

### 4.2 x86_64 + QEMU

Terminal 1:

```bash
cd lessons/<leccion>
make
make gdb
```

Terminal 2 o VS Code:

- Ejecutar configuracion `Debug ARM64 (QEMU)`.

## 5) Como editar `launch.json` cuando agregas lecciones

Edita el arreglo `inputs[0].options` para incluir la nueva carpeta de leccion. Ejemplo:

```json
"options": [
  "00_hello_world_syscalls",
  "01_registros_y_mov",
  "02_cmp_y_flags_basico"
]
```

Si no aparece una leccion en el selector, normalmente falta agregarla aqui.

## 6) Plantilla minima de ambas configuraciones

```json
{
  "name": "Debug ARM64 (nativo)",
  "type": "cppdbg",
  "request": "launch",
  "program": "${workspaceFolder}/lessons/${input:lesson}/build/main",
  "cwd": "${workspaceFolder}/lessons/${input:lesson}",
  "MIMode": "gdb",
  "miDebuggerPath": "/usr/bin/gdb",
  "stopAtEntry": true,
  "setupCommands": [
    { "text": "-enable-pretty-printing" },
    { "text": "set architecture aarch64" }
  ]
}
```

```json
{
  "name": "Debug ARM64 (QEMU)",
  "type": "cppdbg",
  "request": "launch",
  "program": "${workspaceFolder}/lessons/${input:lesson}/build/main",
  "cwd": "${workspaceFolder}/lessons/${input:lesson}",
  "MIMode": "gdb",
  "miDebuggerPath": "/usr/bin/gdb-multiarch",
  "miDebuggerServerAddress": "localhost:1234",
  "stopAtEntry": true,
  "setupCommands": [
    { "text": "-enable-pretty-printing" },
    { "text": "set architecture aarch64" },
    { "text": "set breakpoint auto-hw on" }
  ]
}
```

## 7) Checklist rapido

- `build/main` existe y fue compilado con `-g`.
- La leccion aparece en `inputs.options`.
- Si usas QEMU, `make gdb` sigue corriendo en otra terminal.
- Los breakpoints en `.s` se activan.

## 8) Fallas comunes

- **Seleccionaste config incorrecta:** nativo vs QEMU.
- **No conecta a 1234:** no corriste `make gdb` o el puerto esta ocupado.
- **No aparece codigo fuente:** `program`/`cwd` apuntan a ruta equivocada.
- **No aparece tu leccion en selector:** falta en `inputs.options`.

## 9) Referencia complementaria

- `docs/01_setup_and_workflows.md`
- `docs/03_makefile_usage.md`
