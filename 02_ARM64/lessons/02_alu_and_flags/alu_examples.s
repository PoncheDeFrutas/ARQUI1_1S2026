/* =========================================================
 * Leccion 02 - ALU y banderas en ARM64 (Linux)
 * Archivo: alu_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos de ALU/flags.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0 = codigo de retorno de cada demo (0 = ok, !=0 error)
 * x1 = operando A / valor a comparar
 * x2 = operando B / mascara
 * x3 = resultado intermedio principal
 * x4 = resultado secundario (demo 1)
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Sin datos estaticos para estas funciones.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_add_sub_cmp
.global demo_logic_tst
.global demo_signed_cmp

demo_add_sub_cmp:
    /* -----------------------------------------------------
     * Demo 1: add/sub + cmp + b.eq
     *
     * x1 = 12, x2 = 7, x3 = x1 + x2, x4 = x1 - x2
     * Si x3 == 19, la demo pasa.
     * ----------------------------------------------------- */
    mov     x1, #12              // operando A
    mov     x2, #7               // operando B
    add     x3, x1, x2           // x3 = 19
    sub     x4, x1, x2           // x4 = 5 (referencia)

    cmp     x3, #19              // compara x3 con 19
    b.eq    demo1_ok             // usa bandera Z

    mov     x0, #1               // error en demo 1
    ret

demo1_ok:
    mov     x0, #0               // exito
    ret

demo_logic_tst:
    /* -----------------------------------------------------
     * Demo 2: and/tst + b.ne
     * -----------------------------------------------------
     * x1 = 0b1010 (10)
     * x2 = 0b0010 (2)
     * and esperado = 0b0010 (2)
     * ----------------------------------------------------- */
    mov     x1, #10              // 0b1010
    mov     x2, #2               // 0b0010
    and     x3, x1, x2           // x3 = 2

    cmp     x3, #2
    b.ne    demo2_error

    tst     x1, x2               // prueba bits en comun (actualiza Z)
    b.ne    demo2_ok             // Z=0 -> hubo bits en comun

demo2_error:
    mov     x0, #2               // error en demo 2
    ret

demo2_ok:
    mov     x0, #0               // exito
    ret

demo_signed_cmp:
    /* -----------------------------------------------------
     * Demo 3: comparacion firmada con b.lt
     * -----------------------------------------------------
     * Verifica que -5 es menor que 0 usando comparacion signed.
     * ----------------------------------------------------- */
    mov     x1, #-5              // valor signed negativo
    cmp     x1, #0
    b.lt    demo3_ok             // signed lower-than

    mov     x0, #3               // error en demo 3
    ret

demo3_ok:
    mov     x0, #0               // exito
    ret
