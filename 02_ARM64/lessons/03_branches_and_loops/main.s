/* =========================================================
 * Leccion 03 - Branches y loops en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Este archivo muestra un menu para ejecutar demos.
 * ========================================================= */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data

menu_msg:
    .ascii "\n[Leccion 03] Branches y loops\n"
    .ascii "1) Demo for: suma 1..5\n"
    .ascii "2) Demo while: suma pares 2..10\n"
    .ascii "3) Demo do-while: countdown 5..1\n"
    .ascii "Seleccion (1-3, Enter=1): "
    menu_msg_len = . - menu_msg

invalid_msg:
    .ascii "Opcion invalida. Se usara codigo de error.\n"
    invalid_msg_len = . - invalid_msg

opt_buf:
    .space 2

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

.extern demo_for_sum_1_to_5
.extern demo_while_even_sum
.extern demo_do_while_countdown

_start:
    /* -----------------------------------------------------
     * 1) Mostrar menu en stdout
     * ----------------------------------------------------- */
    mov     x0, #1
    adr     x1, menu_msg
    mov     x2, menu_msg_len
    mov     x8, #64
    svc     #0

    /* -----------------------------------------------------
     * 2) Leer opcion desde stdin
     * ----------------------------------------------------- */
    mov     x0, #0
    adr     x1, opt_buf
    mov     x2, #2
    mov     x8, #63
    svc     #0

    cmp     x0, #0
    b.eq    run_demo_1

    adr     x10, opt_buf
    ldrb    w11, [x10]

    cmp     w11, #'1'
    b.eq    run_demo_1
    cmp     w11, #'2'
    b.eq    run_demo_2
    cmp     w11, #'3'
    b.eq    run_demo_3
    b       invalid_option

run_demo_1:
    bl      demo_for_sum_1_to_5
    b       exit_program

run_demo_2:
    bl      demo_while_even_sum
    b       exit_program

run_demo_3:
    bl      demo_do_while_countdown
    b       exit_program

invalid_option:
    /* -----------------------------------------------------
     * 3) Manejo de opcion invalida
     * ----------------------------------------------------- */
    mov     x0, #1
    adr     x1, invalid_msg
    mov     x2, invalid_msg_len
    mov     x8, #64
    svc     #0
    mov     x0, #9

exit_program:
    /* -----------------------------------------------------
     * 4) Finalizar programa con exit(x0)
     * ----------------------------------------------------- */
    mov     x8, #93
    svc     #0
