/* =========================================================
 * Leccion 07 - Tipos de datos y extension en ARM64 (Linux)
 * Archivo: type_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos de extension de datos.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0 = codigo de retorno de cada demo (0 = ok, !=0 error)
 * x1 = valor cargado desde memoria (demo 1 y 2)
 * x3 = registro para demo wN/xN
 * x4 = constante esperada en demo 3
 * x10 = base de bloque de datos
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data

byte_unsigned:
    .byte 0xF2                  // 242 en unsigned

byte_signed:
    .byte 0xF2                  // -14 en signed int8

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_zero_extension
.global demo_sign_extension
.global demo_w_register_zeroes_upper

demo_zero_extension:
    /* -----------------------------------------------------
     * Demo 1: zero extension con ldrb
     * -----------------------------------------------------
     * ldrb carga 8 bits y completa con ceros en el registro.
     * Si byte = 0xF2, en x1 debe quedar 0x000...00F2 (242).
     * ----------------------------------------------------- */
    adr     x10, byte_unsigned
    ldrb    w1, [x10]           // zero extension hacia x1

    cmp     x1, #0xF2
    b.eq    demo1_ok

    mov     x0, #1
    ret

demo1_ok:
    mov     x0, #0
    ret


demo_sign_extension:
    /* -----------------------------------------------------
     * Demo 2: sign extension con ldrsb
     * -----------------------------------------------------
     * ldrsb carga 8 bits y extiende signo.
     * byte 0xF2 interpretado como int8 = -14.
     * En x1 debe quedar 0xFFF...FFF2 (-14 en 64 bits).
     * ----------------------------------------------------- */
    adr     x10, byte_signed
    ldrsb   x1, [x10]           // sign extension a 64 bits

    cmp     x1, #-14
    b.eq    demo2_ok

    mov     x0, #2
    ret

demo2_ok:
    mov     x0, #0
    ret


demo_w_register_zeroes_upper:
    /* -----------------------------------------------------
     * Demo 3: escribir en wN limpia parte alta de xN
     * -----------------------------------------------------
    * Paso A) x3 = -1 (todos los bits en 1)
     * Paso B) construir 0x12345678 en w3 (movz/movk)
     *         -> x3 = 0x0000000012345678
     * ----------------------------------------------------- */
    mov     x3, #-1
    movz    w3, #0x5678
    movk    w3, #0x1234, lsl #16

    movz    x4, #0x5678
    movk    x4, #0x1234, lsl #16
    cmp     x3, x4
    b.eq    demo3_ok

    mov     x0, #3
    ret

demo3_ok:
    mov     x0, #0
    ret
