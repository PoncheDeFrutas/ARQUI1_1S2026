/* =========================================================
 * Leccion 07 - Tipos de datos y extension en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: ejecutar demos de sign/zero extension.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0  = fd para read/write, bytes leidos y codigo de salida
 * x1  = direccion de buffer para read/write
 * x2  = cantidad de bytes para read/write
 * x8  = numero de syscall Linux ARM64
 * x10 = base de opt_buf
 * w11 = primer caracter leido (opcion de menu)
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data

menu_msg:
    .ascii "\n[Leccion 07] Tipos y extension\n"
    .ascii "1) Zero extension con ldrb\n"
    .ascii "2) Sign extension con ldrsb\n"
    .ascii "3) Efecto de escribir en wN sobre xN\n"
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

.extern demo_zero_extension
.extern demo_sign_extension
.extern demo_w_register_zeroes_upper

_start:
    /* -----------------------------------------------------
     * syscall: write(stdout, menu_msg, menu_msg_len)
     *
     * x0 = file descriptor (1 = stdout)
     * x1 = direccion del buffer
     * x2 = numero de bytes
     * x8 = numero de syscall (64)
     * ----------------------------------------------------- */
    mov     x0, #1               // stdout
    adr     x1, menu_msg         // buffer del menu
    mov     x2, menu_msg_len     // bytes a escribir
    mov     x8, #64              // syscall write
    svc     #0                   // llamada al kernel

    /* -----------------------------------------------------
     * syscall: read(stdin, opt_buf, 2)
     *
     * x0 = file descriptor (0 = stdin)
     * x1 = direccion del buffer
     * x2 = numero de bytes maximos
     * x8 = numero de syscall (63)
     * ----------------------------------------------------- */
    mov     x0, #0               // stdin
    adr     x1, opt_buf          // buffer para opcion
    mov     x2, #2               // leer 1 char + posible \n
    mov     x8, #63              // syscall read
    svc     #0                   // llamada al kernel

    cmp     x0, #0               // bytes leidos
    b.eq    run_demo_1           // EOF: demo 1 por defecto

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
    bl      demo_zero_extension
    b       exit_program

run_demo_2:
    bl      demo_sign_extension
    b       exit_program

run_demo_3:
    bl      demo_w_register_zeroes_upper
    b       exit_program

invalid_option:
    /* -----------------------------------------------------
     * syscall: write(stdout, invalid_msg, invalid_msg_len)
     *
     * x0 = file descriptor (1 = stdout)
     * x1 = direccion del buffer
     * x2 = numero de bytes
     * x8 = numero de syscall (64)
     * ----------------------------------------------------- */
    mov     x0, #1               // stdout
    adr     x1, invalid_msg      // mensaje de error
    mov     x2, invalid_msg_len  // longitud del mensaje
    mov     x8, #64              // syscall write
    svc     #0                   // llamada al kernel

    mov     x0, #9               // codigo de opcion invalida

exit_program:
    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel
