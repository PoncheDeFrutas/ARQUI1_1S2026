# Ruta de aprendizaje ARM64 (ARMv8) para IoT

Este documento define el camino oficial de aprendizaje para la seccion ARM64. La progresion esta pensada para que el estudiante llegue a resolver problemas de memoria, manejo de datos de distinto tamano y operaciones con matrices en ensamblador.

## Objetivo formativo global

Al finalizar la ruta, el estudiante debe poder:

- Modelar datos en memoria (escalares, arreglos y matrices).
- Implementar operaciones de procesamiento numerico en ARM64.
- Aplicar ABI AArch64 para funciones modulares y reutilizables.
- Depurar paso a paso registros, stack y memoria con GDB.
- Entender la base para evolucionar a MMIO/GPIO en Raspberry Pi.

## Competencias por fases

### Fase 0 - Fundamentos de ejecucion

- `_start`, flujo de programa y syscalls Linux.
- Toolchain (`as`, `ld`, `make`) y ciclo build/run/debug.
- Diferencia entre ejecutar nativo ARM64 y emulado con QEMU.

**Resultado esperado:** el estudiante compila, ejecuta y depura un programa minimo sin libc.

### Fase 1 - ISA basica

- Registros `x0-x30` y vista `w0-w30`.
- Instrucciones aritmeticas/logicas basicas.
- Saltos, comparaciones y control de flujo.

**Resultado esperado:** puede construir ciclos y condiciones sin apoyo de C.

### Fase 2 - Memoria y direccionamiento

- Segmentos `.text`, `.data`, `.bss`.
- `ldr/str/ldrb/strb/ldrh/strh` y modos de direccionamiento.
- Alineacion, offsets, punteros y recorridos en memoria.

**Resultado esperado:** puede leer/escribir buffers y evitar errores comunes de direccion.

### Fase 3 - Funciones y ABI

- Convencion de llamada AArch64 (argumentos, retorno, preservacion de registros).
- Prologo/epilogo y stack frame.
- Multiarchivo (`main.s` + modulos auxiliares).

**Resultado esperado:** puede separar logica en funciones correctas y depurables.

### Fase 4 - Tipos de datos y precision

- Enteros con signo y sin signo.
- Extension de signo y cero (`sxt*`, `uxt*`, `ldrs*`).
- Conversiones y operaciones entre 8/16/32/64 bits.

**Resultado esperado:** manipula tipos mixtos sin corromper datos.

### Fase 5 - Arreglos 1D

- Indexacion lineal con stride.
- Recorridos, reducciones (`sum`, `min`, `max`) y transformaciones.
- Patrones de acumulacion y validacion de resultados.

**Resultado esperado:** implementa kernels simples de procesamiento de datos.

### Fase 6 - Matrices 2D

- Layout row-major en memoria lineal.
- Formula de direccion: `base + ((i * cols) + j) * elem_size`.
- Operaciones: suma, resta, transpuesta y multiplicacion.

**Resultado esperado:** implementa operaciones matriciales correctas y verificables.

### Fase 7 - Optimizacion y puente a IoT

- Reducir accesos a memoria y mejorar orden de loops.
- Instrumentacion de pruebas y casos borde.
- Introduccion conceptual a MMIO/GPIO para etapa posterior.

**Resultado esperado:** puede justificar decisiones de rendimiento y robustez.

## Mapa sugerido de lecciones

1. `00_hello_world_syscalls`
2. `01_registros_y_mov`
3. `02_cmp_y_flags_basico`
4. `03_if_simple`
5. `04_if_else`
6. `05_if_elseif_else`
7. `06_loops_while_for`
8. `07_alu_matematica_basica`
9. `08_alu_logica_y_bits`
10. `09_memoria_load_store_basico`
11. `10_stack_y_funciones`
12. `11_abi_y_multiarchivo`
13. `12_tipos_y_extension_signo_cero`
14. `13_arreglos_1d`
15. `14_matrices_indexado_2d`
16. `15_matrices_operaciones`
17. `16_multiplicacion_matrices_basica`
18. `17_proyecto_iot_datos`

## Criterios minimos por leccion

Cada leccion debe incluir:

- Objetivo de aprendizaje.
- Prerrequisitos claros.
- Conceptos nuevos (maximo 3-5 por leccion para mantener foco).
- Comandos `make`, `make run`, `make gdb`.
- Salida esperada y checklist de validacion.
- Errores comunes y como diagnosticarlos.

## Evaluacion recomendada

- **Nivel basico:** programas que usen syscalls, ciclos y condiciones.
- **Nivel intermedio:** funciones multiarchivo con stack y ABI correcto.
- **Nivel avanzado:** kernels de arreglos y matrices con distintos tamanos de dato.
- **Proyecto final:** pipeline de datos estilo IoT (entrada simulada -> transformacion -> salida).
