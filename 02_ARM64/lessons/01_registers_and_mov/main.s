/* =========================================================
 * Leccion 01 - Registros y mov en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: practicar uso de registros xN/wN y mov.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere datos estaticos en .data.
 * Todas las constantes se cargan como inmediatos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * 1) Cargar valores inmediatos en registros de trabajo
     * ----------------------------------------------------- */
    mov     x1, #5               // operando A
    mov     x2, #10              // operando B

    /* -----------------------------------------------------
     * 2) Operar sobre registros (suma en 64 bits)
     * -----------------------------------------------------
     * El resultado queda en x3 para poder inspeccionarlo
     * en depuracion sin afectar el codigo de salida.
     * ----------------------------------------------------- */
    add     x3, x1, x2           // x3 = 5 + 10 = 15

    /* -----------------------------------------------------
     * 3) Finalizar programa con syscall exit(0)
     * -----------------------------------------------------
     * x0 = codigo de salida
     * x8 = numero de syscall (93 = exit)
     * ----------------------------------------------------- */
    mov     x0, #0               // salida exitosa
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
