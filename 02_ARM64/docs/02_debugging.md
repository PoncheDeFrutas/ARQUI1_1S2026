# Depuracion ARM64 con GDB y VS Code

Esta guia resume el flujo de depuracion para practicas ARM64 en Linux, tanto nativo (Raspberry Pi) como emulado (QEMU en x86_64).

## 1) Flujo nativo ARM64

Dentro de la carpeta de la leccion:

```bash
make
make gdb
```

Si prefieres manual:

```bash
gdb ./build/main
```

Comandos utiles en GDB:

- `break _start`
- `run`
- `layout regs`
- `x/16gx $sp`
- `info registers`
- `si` (step instruction)

## 2) Flujo x86_64 + QEMU

Terminal 1:

```bash
make
make gdb
```

Terminal 2:

```bash
gdb-multiarch ./build/main
(gdb) set architecture aarch64
(gdb) target remote localhost:1234
```

## 3) Configuracion VS Code recomendada

El proyecto trae una configuracion base en `02_ARM64/.vscode/launch.json` para modo nativo. Para flujo QEMU agrega otra configuracion con `miDebuggerServerAddress: "localhost:1234"` y `miDebuggerPath: "/usr/bin/gdb-multiarch"`.

## 4) Checklist de depuracion

- El binario fue generado con `-g`.
- El breakpoint se activa en `_start` o en etiqueta esperada.
- Puedes inspeccionar registros `x0-x30`.
- Puedes inspeccionar memoria de `.data` y stack.

## 5) Fallas frecuentes

- **No conecta a puerto 1234:** QEMU no esta corriendo o el puerto esta ocupado.
- **Breakpoint no engancha:** recompila (`make clean && make`) y verifica simbolos.
- **Archivo fuente no se muestra en VS Code:** valida rutas de `program` y `cwd`.

## 6) Documento historico

La guia extensa anterior permanece en `debugging-aarch64-vscode.md` como referencia de compatibilidad.
