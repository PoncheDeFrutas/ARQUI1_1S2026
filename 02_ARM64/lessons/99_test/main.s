/* =========================================================
 * Leccion 99 - Prueba multiarchivo ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Este archivo contiene _start y llama a sum (add.s).
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0  = argumento 1 para sum y luego codigo de salida
 * x1  = argumento 2 para sum
 * x8  = numero de syscall Linux ARM64
 * x30 = link register (retorno de bl)
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta practica no necesita datos en memoria estatica.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

.extern sum                    // funcion definida en add.s

_start:
    /* -----------------------------------------------------
     * 1) Preparar argumentos para sum(a, b)
     * -----------------------------------------------------
     * ABI AArch64:
     *   x0 = argumento 1
     *   x1 = argumento 2
     * ----------------------------------------------------- */
    mov     x0, #5             // a = 5
    mov     x1, #10            // b = 10

    /* -----------------------------------------------------
     * 2) Llamar funcion externa
     * -----------------------------------------------------
     * bl guarda retorno en x30 (lr) y salta a sum.
     * La funcion devuelve resultado en x0.
     * ----------------------------------------------------- */
    bl      sum                // x0 = 15 al retornar

    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida (resultado de sum)
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93            // syscall exit
    svc     #0                 // llamada al kernel
