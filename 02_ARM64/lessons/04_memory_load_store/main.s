/* =========================================================
 * Leccion 04 - Memoria, load y store en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: leer/escribir variables en .data con ldr/str.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Variables de 64 bits alineadas para acceso sencillo.
 * --------------------------------------------------------- */
.section .data

a:
    .quad 10                    // primer valor

b:
    .quad 20                    // segundo valor

result:
    .quad 0                     // salida de la suma

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * 1) Obtener direccion base del bloque de datos
     * ----------------------------------------------------- */
    adr     x10, a              // x10 = &a

    /* -----------------------------------------------------
     * 2) Cargar valores desde memoria
     * -----------------------------------------------------
     * Layout:
     *   a      en offset #0
     *   b      en offset #8
     *   result en offset #16
     * ----------------------------------------------------- */
    ldr     x1, [x10, #0]       // x1 = a
    ldr     x2, [x10, #8]       // x2 = b

    /* -----------------------------------------------------
     * 3) Operar y guardar resultado en memoria
     * ----------------------------------------------------- */
    add     x3, x1, x2          // x3 = a + b = 30
    str     x3, [x10, #16]      // result = 30

    /* -----------------------------------------------------
     * 4) Releer resultado y validar
     * ----------------------------------------------------- */
    ldr     x4, [x10, #16]      // x4 = result
    cmp     x4, #30
    b.eq    ok

error:
    mov     x0, #1              // codigo de error
    b       exit_program

ok:
    mov     x0, #0              // codigo de exito

exit_program:
    /* -----------------------------------------------------
     * 5) Finalizar programa
     * ----------------------------------------------------- */
    mov     x8, #93             // syscall exit
    svc     #0
