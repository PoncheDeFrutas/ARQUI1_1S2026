/* =========================================================
 * Leccion 04 - If else en ARM64 (Linux)
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
 * x1 = valor de entrada
 * x2 = salida logica (1 impar, 0 par)
 * x3 = auxiliar para mascara de bits
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
     * 1) Caso base
     * -----------------------------------------------------
     * Queremos modelar:
     *   if (x1 & 1) x2 = 1; else x2 = 0;
     * ----------------------------------------------------- */
    mov     x1, #7               // valor de entrada (impar)
    mov     x2, #0               // salida por defecto

    /* -----------------------------------------------------
     * 2) Evaluar condicion
     * ----------------------------------------------------- */
    and     x3, x1, #1           // extrae bit menos significativo
    cmp     x3, #0               // compara con cero
    b.eq    else_branch          // si es cero, rama falsa

    /* Rama verdadera */
    mov     x2, #1               // rama verdadera: impar
    b       end_if               // saltar rama else

else_branch:
    /* Rama falsa */
    mov     x2, #0               // rama falsa: par

end_if:
    /* -----------------------------------------------------
     * 3) Validar resultado
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
