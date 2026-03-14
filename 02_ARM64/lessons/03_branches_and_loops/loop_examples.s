/* =========================================================
 * Leccion 03 - Branches y loops en ARM64 (Linux)
 * Archivo: loop_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos de loops clasicos.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Sin datos estaticos para estas funciones.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_for_sum_1_to_5
.global demo_while_even_sum
.global demo_do_while_countdown

demo_for_sum_1_to_5:
    /* -----------------------------------------------------
     * Demo 1: estilo for
     * for (i = 1; i <= 5; i++) sum += i;
     * Resultado esperado: 15
     * ----------------------------------------------------- */
    mov     x1, #1               // i = 1
    mov     x2, #0               // sum = 0

for_loop:
    cmp     x1, #5
    b.gt    for_end
    add     x2, x2, x1
    add     x1, x1, #1
    b       for_loop

for_end:
    cmp     x2, #15
    b.eq    demo1_ok
    mov     x0, #1
    ret

demo1_ok:
    mov     x0, #0
    ret

demo_while_even_sum:
    /* -----------------------------------------------------
     * Demo 2: estilo while
     * i = 2; while (i <= 10) { sum += i; i += 2; }
     * Resultado esperado: 30
     * ----------------------------------------------------- */
    mov     x1, #2               // i = 2
    mov     x2, #0               // sum = 0

while_check:
    cmp     x1, #10
    b.gt    while_end
    add     x2, x2, x1
    add     x1, x1, #2
    b       while_check

while_end:
    cmp     x2, #30
    b.eq    demo2_ok
    mov     x0, #2
    ret

demo2_ok:
    mov     x0, #0
    ret

demo_do_while_countdown:
    /* -----------------------------------------------------
     * Demo 3: estilo do-while
     * i = 5; do { count++; i--; } while (i != 0);
     * Resultado esperado: count = 5
     * ----------------------------------------------------- */
    mov     x1, #5               // i = 5
    mov     x2, #0               // count = 0

do_loop:
    add     x2, x2, #1
    sub     x1, x1, #1
    cmp     x1, #0
    b.ne    do_loop

    cmp     x2, #5
    b.eq    demo3_ok
    mov     x0, #3
    ret

demo3_ok:
    mov     x0, #0
    ret
