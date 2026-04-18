/* =========================================================
 * Modulo: entrada/salida
 * Archivo: io/input.s
 *
 * Arquitectura: ARMv8 / AArch64 Linux
 *
 * Proposito:
 *   Lee lineas desde stdin y convierte texto a enteros i64.
 *
 * Simbolos publicos:
 *   read_line
 *   read_i64
 *   parse_i64
 *
 * Dependencias:
 *   constants.inc
 * ========================================================= */

.include "constants.inc"

.section .text
.global read_line
.global read_i64
.global parse_i64

/* ---------------------------------------------------------
 * Funcion: read_line
 *
 * Objetivo:
 *   Leer texto desde stdin hacia un buffer.
 *
 * Entradas:
 *   x0 = direccion de buffer
 *   x1 = capacidad del buffer
 *
 * Salidas:
 *   x0 = cantidad de bytes leidos, o 0 si falla
 *   x1 = codigo de estado ERR_*
 *
 * Registros usados:
 *   x19 = buffer
 *   x20 = capacidad
 *   x21 = indice para limpiar buffer
 *   x0/x1/x2/x8 = argumentos de syscall read
 *
 * Procedimiento:
 *   1) Validar capacidad no cero.
 *   2) Limpiar buffer para asegurar terminador NUL.
 *   3) Ejecutar read(stdin, buffer, capacidad - 1).
 *   4) Devolver bytes leidos y estado.
 * --------------------------------------------------------- */
read_line:
    stp x29, x30, [sp, #-48]!
    mov x29, sp
    stp x19, x20, [sp, #16]
    str x21, [sp, #32]

    mov x19, x0
    mov x20, x1
    cbz x20, read_line_range

    /* Zero buffer so parse stops even when input has no newline. */
    mov x21, #0
read_line_clear_loop:
    cmp x21, x20
    b.ge read_line_read
    strb wzr, [x19, x21]
    add x21, x21, #1
    b read_line_clear_loop

read_line_read:
    mov x0, #STDIN
    mov x1, x19
    sub x2, x20, #1
    mov x8, #SYS_READ
    svc #0
    cmp x0, #0
    b.lt read_line_unknown
    mov x1, #ERR_OK
    b read_line_done

read_line_range:
    mov x0, #0
    mov x1, #ERR_RANGE
    b read_line_done

read_line_unknown:
    mov x0, #0
    mov x1, #ERR_UNKNOWN

read_line_done:
    ldr x21, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #48
    ret

/* ---------------------------------------------------------
 * Funcion: read_i64
 *
 * Objetivo:
 *   Leer una linea y convertirla a entero i64.
 *
 * Entradas:
 *   x0 = direccion de buffer
 *   x1 = capacidad del buffer
 *
 * Salidas:
 *   x0 = entero parseado, o 0 si falla
 *   x1 = codigo de estado ERR_*
 *
 * Procedimiento:
 *   1) Leer linea con read_line.
 *   2) Si lectura fue valida, parsear con parse_i64.
 * --------------------------------------------------------- */
read_i64:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    str x19, [sp, #16]

    mov x19, x0
    bl read_line
    cmp x1, #ERR_OK
    b.ne read_i64_done
    mov x0, x19
    bl parse_i64

read_i64_done:
    ldr x19, [sp, #16]
    ldp x29, x30, [sp], #32
    ret

/* ---------------------------------------------------------
 * Funcion: parse_i64
 *
 * Objetivo:
 *   Convertir cadena ASCII a entero signed 64-bit.
 *
 * Entradas:
 *   x0 = direccion de buffer con texto
 *
 * Salidas:
 *   x0 = entero convertido, o 0 si falla
 *   x1 = codigo de estado ERR_*
 *
 * Registros usados:
 *   x2 = cursor de lectura
 *   x3 = signo (+1 o -1)
 *   x4 = contador de digitos
 *   w5 = caracter actual
 *   x6 = base decimal 10
 *
 * Procedimiento:
 *   1) Saltar espacios iniciales.
 *   2) Leer signo opcional.
 *   3) Acumular digitos en base 10.
 *   4) Permitir espacios finales.
 *   5) Rechazar cadena sin digitos o caracteres invalidos.
 * --------------------------------------------------------- */
parse_i64:
    mov x2, x0              /* cursor */
    mov x0, #0              /* value */
    mov x3, #1              /* sign */
    mov x4, #0              /* digits */

parse_skip_spaces:
    ldrb w5, [x2]
    cmp w5, #' '
    b.eq parse_advance_space
    cmp w5, #9
    b.ne parse_sign
parse_advance_space:
    add x2, x2, #1
    b parse_skip_spaces

parse_sign:
    cmp w5, #'-'
    b.ne parse_plus
    mov x3, #-1
    add x2, x2, #1
    b parse_digits

parse_plus:
    cmp w5, #'+'
    b.ne parse_digits
    add x2, x2, #1

parse_digits:
    /* 3) value = value * 10 + digit. */
    ldrb w5, [x2]
    cmp w5, #10
    b.eq parse_end
    cmp w5, #13
    b.eq parse_end
    cbz w5, parse_end
    cmp w5, #' '
    b.eq parse_trailing
    cmp w5, #'0'
    b.lt parse_bad
    cmp w5, #'9'
    b.gt parse_bad

    sub w5, w5, #'0'
    mov x6, #10
    mul x0, x0, x6
    add x0, x0, x5
    add x4, x4, #1
    add x2, x2, #1
    b parse_digits

parse_trailing:
    add x2, x2, #1
parse_trailing_loop:
    ldrb w5, [x2]
    cmp w5, #10
    b.eq parse_end
    cmp w5, #13
    b.eq parse_end
    cbz w5, parse_end
    cmp w5, #' '
    b.ne parse_bad
    add x2, x2, #1
    b parse_trailing_loop

parse_end:
    cbz x4, parse_bad
    cmp x3, #1
    b.eq parse_ok
    neg x0, x0
parse_ok:
    mov x1, #ERR_OK
    ret

parse_bad:
    mov x0, #0
    mov x1, #ERR_INPUT
    ret
