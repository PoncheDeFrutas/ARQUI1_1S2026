# Depuracion RISC-V 64 con VS Code

Esta guia explica como depurar las lecciones de la seccion RISC-V usando QEMU en modo remoto y `gdb-multiarch` desde VS Code.

## 1) Antes de depurar: punto clave del workspace

Abre en VS Code la carpeta `03_RISCV/` (no la raiz completa del repo). Asi, `${workspaceFolder}` apunta correctamente a esta ruta y el `launch.json` funciona sin cambiar paths.

Si abres la raiz del repo, ajusta manualmente `program` y `cwd` para incluir `03_RISCV/`.

## 2) Donde se edita

- Archivo: `03_RISCV/.vscode/launch.json`
- El proyecto trae la configuracion:
  - `Debug RISC-V64 (QEMU)`

En la mayoria de casos no necesitas crear una configuracion nueva; solo elegir la correcta en VS Code.

## 3) Herramientas recomendadas en VS Code

- Extension C/C++ para el backend `cppdbg`.
- Extension `StackScope` si quieres inspeccion visual adicional de stack y memoria durante la depuracion.

## 4) Flujo completo

Terminal 1:

```bash
cd lessons/<leccion>
make
make gdb
```

Terminal 2 o VS Code:

- Ejecutar configuracion `Debug RISC-V64 (QEMU)`.

Si solo quieres validar ejecucion sin depurar:

```bash
cd lessons/<leccion>
make
make run
```

## 5) Como editar `launch.json` cuando agregas lecciones

Edita el arreglo `inputs[0].options` para incluir la nueva carpeta de leccion. Ejemplo:

```json
"options": [
  "00_hello_world_syscalls",
  "01_registros_y_mov"
]
```

Si no aparece una leccion en el selector, normalmente falta agregarla aqui.

## 6) Plantilla minima de la configuracion

```json
{
  "name": "Debug RISC-V64 (QEMU)",
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
    { "text": "set architecture riscv" },
    { "text": "set breakpoint auto-hw on" }
  ]
}
```

## 7) Checklist rapido

- `build/main` existe y fue compilado con `-g`.
- La leccion aparece en `inputs.options`.
- `make gdb` sigue corriendo en otra terminal.
- Los breakpoints en `.s` se activan.

## 8) Fallas comunes

- **No conecta a 1234:** no corriste `make gdb` o el puerto esta ocupado.
- **No aparece codigo fuente:** `program` o `cwd` apuntan a una ruta equivocada.
- **No aparece tu leccion en selector:** falta en `inputs.options`.
- **Usas otra arquitectura en GDB/QEMU:** revisa `miDebuggerPath`, `QEMU` y toolchain.

## 9) Referencia complementaria

- `docs/01_setup_and_workflows.md`
- `docs/03_makefile_usage.md`
