/* =========================================================
 * Leccion 01 - Registros y mov en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x1 = operando A
 * x2 = operando B
 * x3 = resultado de suma
 * x0 = codigo de salida
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

_start:
    /* -----------------------------------------------------
     * 1) Cargar inmediatos en registros
     * ----------------------------------------------------- */
    mov     x1, #5               // operando A
    mov     x2, #10              // operando B

    /* -----------------------------------------------------
     * 2) Operar en registros (x3 = x1 + x2)
     * ----------------------------------------------------- */
    add     x3, x1, x2           // x3 = x1 + x2

    /* -----------------------------------------------------
     * 3) Validar resultado esperado (15)
     * ----------------------------------------------------- */
    cmp     x3, #15              // comparar con valor esperado
    b.ne    error                // si no coincide, error

    mov     x0, #0               // exito
    b       exit_program         // ir a salida

error:
    mov     x0, #1               // error

exit_program:
    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
