/* =========================================================
 * Leccion 11 - ABI y multiarchivo en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere datos estaticos.
 * --------------------------------------------------------- */

/* Registros usados
 * x0 = arg1 y retorno
 * x1 = arg2
 * x2 = arg3
 * x8 = syscall exit
 */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start
.extern combine_and_scale

_start:
    /* Preparar argumentos para funcion externa */
    mov x0,#4                     // arg1 = 4
    mov x1,#6                     // arg2 = 6
    mov x2,#3                     // arg3 = 3

    /* combine_and_scale(4,6,3) = (4+6)*3 = 30 */
    bl combine_and_scale          // llamada a funcion externa

    /* Validar retorno */
    cmp x0,#30                    // validar retorno esperado
    b.ne error                    // error si no coincide
    mov x0,#0                     // codigo de exito
    b exit_program                // finalizar

error:
    mov x0,#1                     // codigo de error

exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                    // syscall exit
    svc #0                        // llamada al kernel
