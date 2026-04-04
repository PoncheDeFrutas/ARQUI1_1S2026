/* =========================================================
 * Leccion 14 - Matrices e indexado 2D en ARM64 (Linux)
 * Archivo: matrix_col_major_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos en column-major y limites.
 * ========================================================= */

/* Registros usados
 * x0 = codigo de retorno
 * x1 = base de la matriz o indice i
 * x2 = indice i o j
 * x3 = indice j o rows
 * x4 = rows o cols
 * x5 = indice lineal
 * x6 = offset en bytes
 * x7 = direccion final
 * x8 = valor leido
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
matrix_col_read: .quad 10, 40, 20, 50, 30, 60    // misma matriz logica 2x3 en column-major

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_col_major_read
.global demo_bounds_check

demo_col_major_read:
    /* Leer A[1][2] en column-major: offset = (j * rows + i) * 8 */
    adr x1,matrix_col_read       // base de la matriz
    mov x2,#1                    // i = 1
    mov x3,#2                    // j = 2
    mov x4,#2                    // rows = 2
    mul x5,x3,x4                 // j * rows
    add x5,x5,x2                 // indice lineal = j*rows + i
    lsl x6,x5,#3                 // offset en bytes
    add x7,x1,x6                 // direccion final
    ldr x8,[x7]                  // leer A[1][2]
    cmp x8,#60                   // validar valor esperado
    b.ne col_fail                // error si no coincide
    mov x0,#0                    // exito
    ret                          // volver al llamador

demo_bounds_check:
    /* Validar i < rows y j < cols antes del acceso */
    mov x1,#2                    // i = 2 (fuera de rango)
    mov x2,#0                    // j = 0
    mov x3,#2                    // rows = 2
    mov x4,#3                    // cols = 3
    cmp x1,x3                    // i >= rows?
    b.hs bounds_rejected         // acceso invalido detectado
    cmp x2,x4                    // j >= cols?
    b.hs bounds_rejected         // acceso invalido detectado
    mov x0,#1                    // seria error aceptar el acceso
    ret                          // volver al llamador

bounds_rejected:
    mov x0,#0                    // exito: limite detectado
    ret                          // volver al llamador

col_fail:
    mov x0,#1                    // codigo de error
    ret                          // volver al llamador
