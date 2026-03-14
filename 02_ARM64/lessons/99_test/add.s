/* =========================================================
 * Leccion 99 - Prueba multiarchivo ARM64 (Linux)
 * Archivo: add.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Define funcion auxiliar sum(a, b).
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0 = argumento 1 y valor de retorno
 * x1 = argumento 2
 * x30 = link register (direccion de retorno)
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Sin datos estaticos para esta funcion.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global sum

sum:
    /* -----------------------------------------------------
     * Funcion: sum(a, b)
     * ABI AArch64:
     *   x0 = argumento 1 (a)
     *   x1 = argumento 2 (b)
     *   x0 = retorno (a + b)
     * ----------------------------------------------------- */
    add     x0, x0, x1         // x0 = x0 + x1
    ret                        // vuelve al llamador (main.s)
