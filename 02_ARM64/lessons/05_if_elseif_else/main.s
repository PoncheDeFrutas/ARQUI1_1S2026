/* =========================================================
 * Leccion 05 - If elseif else en ARM64 (Linux)
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
 * x1 = valor a clasificar
 * x2 = clase resultado (0=cero,1=positivo,2=negativo)
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
     * 1) Entrada de ejemplo
     * -----------------------------------------------------
     * Clasificar x1 como:
     *   0 -> cero
     *   >0 -> positivo
     *   <0 -> negativo
     * ----------------------------------------------------- */
    mov     x1, #-3              // valor de entrada (negativo)
    mov     x2, #-1              // valor temporal sin clasificar

    /* if (x1 == 0) */
    cmp     x1, #0               // comparar con cero
    b.eq    is_zero              // rama if

    /* else if (x1 > 0) */
    b.gt    is_positive          // rama else if

    /* else */
    b       is_negative          // rama else

is_zero:
    mov     x2, #0               // clase cero
    b       end_case             // ir a validacion final

is_positive:
    mov     x2, #1               // clase positivo
    b       end_case             // ir a validacion final

is_negative:
    mov     x2, #2               // clase negativo

end_case:
    /* -----------------------------------------------------
     * 2) Validar clasificacion esperada
     * ----------------------------------------------------- */
    cmp     x2, #2               // esperamos clase negativo
    b.ne    error                // si no coincide, error
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
