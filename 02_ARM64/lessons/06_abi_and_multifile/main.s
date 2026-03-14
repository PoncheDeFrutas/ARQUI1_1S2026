/* =========================================================
 * Leccion 06 - ABI y multiarchivo en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: usar ABI AArch64 entre archivos.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0 = argumento 1 y retorno de funcion
 * x1 = argumento 2
 * x2 = argumento 3
 * x8 = numero de syscall Linux ARM64
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

.extern combine_and_scale

_start:
    /* -----------------------------------------------------
     * 1) Preparar argumentos para combine_and_scale(a,b,esc)
     * -----------------------------------------------------
     * ABI AArch64:
     *   x0 = arg1 (a)
     *   x1 = arg2 (b)
     *   x2 = arg3 (escala)
     * ----------------------------------------------------- */
    mov     x0, #4               // a = 4
    mov     x1, #6               // b = 6
    mov     x2, #3               // escala = 3

    /* -----------------------------------------------------
     * 2) Llamar funcion externa (archivo abi_examples.s)
     * -----------------------------------------------------
     * Esperado: (4 + 6) * 3 = 30
     * ----------------------------------------------------- */
    bl      combine_and_scale    // retorno en x0

    /* -----------------------------------------------------
     * 3) Validar resultado
     * ----------------------------------------------------- */
    cmp     x0, #30
    b.eq    ok

error:
    mov     x0, #1               // codigo de error
    b       exit_program

ok:
    mov     x0, #0               // codigo de exito

exit_program:
    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
