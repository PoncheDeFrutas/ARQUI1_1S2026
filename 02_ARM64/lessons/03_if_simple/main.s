/* =========================================================
 * Leccion 03 - If simple en ARM64 (Linux)
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
 * x1 = valor a evaluar
 * x2 = resultado logico (0/1)
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
     * 1) Caso de entrada
     * -----------------------------------------------------
     * Queremos modelar:
     *   if (x1 > 20) x2 = 1;
     * ----------------------------------------------------- */
    mov     x1, #25              // valor de entrada
    mov     x2, #0               // resultado por defecto

    /* -----------------------------------------------------
     * 2) cmp + branch para el if
     * ----------------------------------------------------- */
    cmp     x1, #20              // compara x1 con 20
    b.le    after_if             // si x1 <= 20, no entra al if
    mov     x2, #1               // rama verdadera: x2 = 1

after_if:
    /* -----------------------------------------------------
     * 3) Validar resultado esperado
     * ----------------------------------------------------- */
    cmp     x2, #1               // validar resultado esperado
    b.ne    error                // si no es 1, error
    mov     x0, #0               // codigo de exito
    b       exit_program         // finalizar

error:
    mov     x0, #1               // codigo de error

exit_program:
    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
