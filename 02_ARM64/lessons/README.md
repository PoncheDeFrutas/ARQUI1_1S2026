# Lecciones ARM64

Indice de practicas de ensamblador ARMv8 del curso.

## Lecciones disponibles

- [00_hello_world](00_hello_world/README.md)
  Primer programa en ARM64 con syscalls (`write`, `exit`) y flujo de build basico.

- [01_registers_and_mov](01_registers_and_mov/README.md)
  Uso de registros `xN`/`wN`, carga de inmediatos con `mov` y salida por codigo de retorno.

- [02_alu_and_flags](02_alu_and_flags/README.md)
  Menu con demos de ALU/flags (`cmp`, `tst`, `b.eq`, `b.ne`, `b.lt`) en formato multiarchivo.

- [03_branches_and_loops](03_branches_and_loops/README.md)
  Menu con demos de `for`, `while` y `do-while` usando branches condicionales.

- [04_memory_load_store](04_memory_load_store/README.md)
  Primer acceso a memoria con `.data`, `ldr`, `str` y validacion de resultados.

- [05_stack_and_functions](05_stack_and_functions/README.md)
  Llamadas a funcion con `bl/ret`, prologo/epilogo y preservacion de registros.

- [06_abi_and_multifile](06_abi_and_multifile/README.md)
  Convencion ABI entre archivos, caller/callee-saved y funciones leaf/no-leaf.

- [07_data_types_sign_zero_extension](07_data_types_sign_zero_extension/README.md)
  Demos de zero/sign extension y efecto de usar registros `wN` sobre `xN`.

- `99_test`
  Leccion de pruebas internas multiarchivo para validar flujo de ensamblado/enlace.

## Plantilla estandar para nuevas lecciones

- [README_TEMPLATE.md](README_TEMPLATE.md)
  Estructura base recomendada para documentar cada leccion (objetivo, prerrequisitos, comandos, checklist, errores comunes y ejercicios).

## Ruta recomendada para nuevas lecciones

1. 00_hello_world
2. 01_registers_and_mov
3. 02_alu_and_flags
4. 03_branches_and_loops
5. 04_memory_load_store
6. 05_stack_and_functions
7. 06_abi_and_multifile
8. 07_data_types_sign_zero_extension
9. 08_arrays_1d
10. 09_matrices_indexing_2d
11. 10_matrix_add_sub
12. 11_matrix_mul_basic
13. 12_mixed_precision_and_fixed_point
14. 13_mmio_intro_gpio_foundations
15. 14_capstone_iot_data_pipeline

Para detalle pedagógico, revisa [../docs/00_curriculum_path.md](../docs/00_curriculum_path.md).
