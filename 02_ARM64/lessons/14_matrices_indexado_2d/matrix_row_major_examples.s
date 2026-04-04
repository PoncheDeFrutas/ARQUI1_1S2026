/* =========================================================
 * Leccion 14 - Matrices e indexado 2D en ARM64 (Linux)
 * Archivo: matrix_row_major_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos en row-major.
 * ========================================================= */

/* Registros usados
 * x0 = codigo de retorno
 * x1 = base de la matriz
 * x2 = indice i
 * x3 = indice j
 * x4 = numero de columnas
 * x5 = indice lineal
 * x6 = offset en bytes
 * x7 = direccion final
 * x8 = valor leido o escrito
 * x9 = valor temporal de validacion
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
matrix_row_read:  .quad 10, 20, 30, 40, 50, 60   // matriz 2x3 row-major
matrix_row_write: .quad 1, 2, 3, 4, 5, 6         // matriz 2x3 row-major

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_row_major_read
.global demo_row_major_write

demo_row_major_read:
    /* Leer A[1][2] en row-major: offset = (i * cols + j) * 8 */
    adr x1,matrix_row_read       // base de la matriz
    mov x2,#1                    // i = 1
    mov x3,#2                    // j = 2
    mov x4,#3                    // cols = 3
    mul x5,x2,x4                 // i * cols
    add x5,x5,x3                 // indice lineal = i*cols + j
    lsl x6,x5,#3                 // offset en bytes = indice * 8
    add x7,x1,x6                 // direccion de A[1][2]
    ldr x8,[x7]                  // leer A[1][2]
    cmp x8,#60                   // validar valor esperado
    b.ne row_fail                // error si no coincide
    mov x0,#0                    // exito
    ret                          // volver al llamador

demo_row_major_write:
    /* Escribir A[1][1] = 99 en una matriz row-major */
    adr x1,matrix_row_write      // base de la matriz
    mov x2,#1                    // i = 1
    mov x3,#1                    // j = 1
    mov x4,#3                    // cols = 3
    mul x5,x2,x4                 // i * cols
    add x5,x5,x3                 // indice lineal = i*cols + j
    lsl x6,x5,#3                 // offset en bytes
    add x7,x1,x6                 // direccion de A[1][1]
    mov x8,#99                   // nuevo valor
    str x8,[x7]                  // A[1][1] = 99
    ldr x9,[x7]                  // releer posicion escrita
    cmp x9,#99                   // validar escritura
    b.ne row_fail                // error si no coincide
    ldr x9,[x1,#24]              // leer A[1][0]
    cmp x9,#4                    // validar vecino izquierdo
    b.ne row_fail                // error si fue alterado
    ldr x9,[x1,#40]              // leer A[1][2]
    cmp x9,#6                    // validar vecino derecho
    b.ne row_fail                // error si fue alterado
    mov x0,#0                    // exito
    ret                          // volver al llamador

row_fail:
    mov x0,#1                    // codigo de error
    ret                          // volver al llamador
