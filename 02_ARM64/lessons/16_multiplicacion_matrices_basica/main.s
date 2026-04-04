/* =========================================================
 * Leccion 16 - Multiplicacion de matrices en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* Registros usados
 * x0 = codigo de retorno
 * x8 = numero de syscall
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere menu ni datos locales.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start
.extern demo_matrix_multiply

_start:
    /* Ejecutar demo principal de multiplicacion matricial */
    bl demo_matrix_multiply       // x0 = 0 si todo coincide

    /* syscall: exit(x0) */
    mov x8,#93                    // syscall exit
    svc #0                        // llamada al kernel
