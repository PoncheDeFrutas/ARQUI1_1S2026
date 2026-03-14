/* =========================================================
 * Leccion 02 - ALU y banderas en ARM64 (Linux)
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
    .ascii "\n[Leccion 02] ALU y banderas\n"
    .ascii "1) add/sub + cmp + b.eq\n"
    .ascii "2) and/tst + b.ne\n"
    .ascii "3) cmp firmado + b.lt\n"
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

.extern demo_add_sub_cmp
.extern demo_logic_tst
.extern demo_signed_cmp

_start:
    /* -----------------------------------------------------
     * 1) Mostrar menu en stdout
     * ----------------------------------------------------- */
    mov     x0, #1               // fd = stdout
    adr     x1, menu_msg         // buffer del menu
    mov     x2, menu_msg_len     // bytes a escribir
    mov     x8, #64              // syscall write
    svc     #0

    /* -----------------------------------------------------
     * 2) Leer opcion desde stdin
     * -----------------------------------------------------
     * Si no llega entrada (EOF), usamos opcion 1 por defecto.
     * ----------------------------------------------------- */
    mov     x0, #0               // fd = stdin
    adr     x1, opt_buf
    mov     x2, #2               // leer 1 char + posible \n
    mov     x8, #63              // syscall read
    svc     #0

    cmp     x0, #0               // bytes leidos
    b.eq    run_demo_1

    adr     x10, opt_buf
    ldrb    w11, [x10]           // primer caracter

    cmp     w11, #'1'
    b.eq    run_demo_1
    cmp     w11, #'2'
    b.eq    run_demo_2
    cmp     w11, #'3'
    b.eq    run_demo_3
    b       invalid_option

run_demo_1:
    bl      demo_add_sub_cmp     // x0 = codigo de retorno
    b       exit_program

run_demo_2:
    bl      demo_logic_tst       // x0 = codigo de retorno
    b       exit_program

run_demo_3:
    bl      demo_signed_cmp      // x0 = codigo de retorno
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
    mov     x0, #9               // error de seleccion

exit_program:
    /* -----------------------------------------------------
     * 4) Finalizar programa con exit(x0)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0
