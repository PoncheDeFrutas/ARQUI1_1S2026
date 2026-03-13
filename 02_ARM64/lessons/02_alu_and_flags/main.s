/* =========================================================
 * Leccion 02 - ALU y banderas en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: practicar ALU, cmp y branch condicional.
 * ========================================================= */

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

_start:
    /* -----------------------------------------------------
     * 1) Operaciones basicas de ALU
     * ----------------------------------------------------- */
    mov     x1, #12              // operando A
    mov     x2, #7               // operando B
    add     x3, x1, x2           // x3 = 19
    sub     x4, x1, x2           // x4 = 5 (referencia)

    /* -----------------------------------------------------
     * 2) Comparar resultado y usar bandera Z
     * -----------------------------------------------------
     * cmp hace una resta interna (x3 - 19) y solo actualiza
     * banderas. Si son iguales, Z=1 y saltamos a ok.
     * ----------------------------------------------------- */
    cmp     x3, #19
    b.eq    ok

error:
    /* -----------------------------------------------------
     * Rama de error: resultado inesperado
     * ----------------------------------------------------- */
    mov     x0, #1               // codigo de error
    b       exit_program

ok:
    /* -----------------------------------------------------
     * Rama correcta: validacion exitosa
     * ----------------------------------------------------- */
    mov     x0, #0               // codigo de exito

exit_program:
    /* -----------------------------------------------------
     * 3) Finalizar con syscall exit(x0)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0
