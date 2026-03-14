/* =========================================================
 * Leccion 07 - ALU matematica basica en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* Registros usados
 * x0  = fd para read/write y codigo de salida
 * x1,x2 = operandos de ALU
 * x3,x4 = resultados intermedios
 * x8  = numero de syscall
 * x10 = base del buffer de opcion
 * w11 = opcion del menu
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
menu: .ascii "1) add/sub\n2) mul\nSeleccion (1-2): "
menu_len = . - menu
opt: .space 2

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * syscall: write(stdout, menu, menu_len)
     *
     * x0 = file descriptor (1 = stdout)
     * x1 = direccion del buffer
     * x2 = numero de bytes
     * x8 = numero de syscall (64)
     * ----------------------------------------------------- */
    mov     x0, #1               // stdout
    adr     x1, menu             // direccion del menu
    mov     x2, menu_len         // longitud del menu
    mov     x8, #64              // syscall write
    svc     #0                   // llamada al kernel

    /* -----------------------------------------------------
     * syscall: read(stdin, opt, 2)
     *
     * x0 = file descriptor (0 = stdin)
     * x1 = direccion del buffer
     * x2 = numero maximo de bytes
     * x8 = numero de syscall (63)
     * ----------------------------------------------------- */
    mov     x0, #0               // stdin
    adr     x1, opt              // buffer de opcion
    mov     x2, #2               // leer 2 bytes maximo
    mov     x8, #63              // syscall read
    svc     #0                   // llamada al kernel

    adr x10,opt                  // base del buffer
    ldrb w11,[x10]               // primer caracter leido
    cmp w11,#'2'                 // opcion 2?
    b.eq demo_mul                // ir a demo mul

demo_add_sub:
    /* Demo 1: operaciones matematicas basicas */
    mov x1,#9                    // operando A
    mov x2,#4                    // operando B
    add x3,x1,x2       // 13
    sub x4,x1,x2       // 5
    cmp x3,#13                   // validar suma
    b.ne error                   // error si falla
    cmp x4,#5                    // validar resta
    b.ne error                   // error si falla
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

demo_mul:
    /* Demo 2: multiplicacion */
    mov x1,#6                    // operando A
    mov x2,#7                    // operando B
    mul x3,x1,x2       // 42
    cmp x3,#42                   // validar multiplicacion
    b.ne error                   // error si falla
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

error:
    mov x0,#1                    // codigo de error
exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
