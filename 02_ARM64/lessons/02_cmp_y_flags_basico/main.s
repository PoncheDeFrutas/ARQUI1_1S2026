/* =========================================================
 * Leccion 02 - CMP y flags basico en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados
 * ---------------------------------------------------------
 * x0 = codigo de salida
 * x1 = operando A de comparacion
 * x2 = operando B de comparacion
 * x8 = syscall exit
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no necesita datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * Caso 1: igualdad
     * -----------------------------------------------------
     * cmp x1, x2 con valores iguales debe dejar Z=1.
     * Si no se cumple, vamos a error.
     * ----------------------------------------------------- */
    mov     x1, #8               // operando A
    mov     x2, #8               // operando B
    cmp     x1, x2               // actualiza flags con x1-x2
    b.ne    error                // si no son iguales, error

    /* -----------------------------------------------------
     * Caso 2: comparacion signed "menor que"
     * -----------------------------------------------------
     * -2 < 1 en signed, por eso b.lt debe tomar la rama ok.
     * ----------------------------------------------------- */
    mov     x1, #-2              // valor signed negativo
    mov     x2, #1               // valor positivo
    cmp     x1, x2               // compara signed
    b.lt    ok                   // si x1 < x2, exito

error:
    mov     x0, #1               // codigo de error
    b       exit_program         // finalizar

ok:
    mov     x0, #0               // codigo de exito

exit_program:
    /* syscall: exit(x0) */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
