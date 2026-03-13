/* =========================================================
 * Leccion 03 - Branches y loops en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: controlar flujo con loops y branches.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion trabaja solo con registros.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * 1) Inicializar contador y acumulador
     * -----------------------------------------------------
     * x1 = i (contador)
     * x2 = suma acumulada
     * ----------------------------------------------------- */
    mov     x1, #1               // i = 1
    mov     x2, #0               // suma = 0

loop_start:
    /* -----------------------------------------------------
     * 2) Cuerpo del loop: suma += i
     * ----------------------------------------------------- */
    add     x2, x2, x1           // suma = suma + i
    add     x1, x1, #1           // i++

    /* -----------------------------------------------------
     * 3) Condicion del loop: repetir mientras i <= 5
     * ----------------------------------------------------- */
    cmp     x1, #5
    b.le    loop_start

    /* -----------------------------------------------------
     * 4) Validar resultado final
     * -----------------------------------------------------
     * Se espera suma = 15 (1+2+3+4+5).
     * ----------------------------------------------------- */
    cmp     x2, #15
    b.eq    ok

error:
    mov     x0, #1               // codigo de error
    b       exit_program

ok:
    mov     x0, #0               // codigo de exito

exit_program:
    /* -----------------------------------------------------
     * 5) Finalizar programa
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0
