/* =========================================================
 * Leccion 16 - Multiplicacion de matrices en ARM64 (Linux)
 * Archivo: matrix_mul_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene la demo de multiplicacion 2x3 * 3x2.
 * ========================================================= */

/* Registros usados
 * x0  = codigo de retorno
 * x1  = rowsA
 * x2  = colsA
 * x3  = rowsB
 * x4  = colsB
 * x5  = direccion temporal
 * x6  = valor A[i][k]
 * x7  = direccion temporal
 * x8  = valor B[k][j]
 * x9  = producto parcial
 * x10 = base de A
 * x11 = base de B
 * x12 = base de C
 * x13 = indice i
 * x14 = indice j
 * x15 = acumulador de C[i][j]
 * x16 = indice k
 * x17 = indice lineal u offset temporal
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
matrix_a:        .quad 1, 2, 3, 4, 5, 6
matrix_b:        .quad 7, 8, 9, 10, 11, 12
matrix_c:        .quad 0, 0, 0, 0
matrix_expected: .quad 58, 64, 139, 154

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_matrix_multiply

demo_matrix_multiply:
    /* Validar dimensiones: colsA debe ser igual a rowsB */
    mov x1,#2                    // rowsA = 2
    mov x2,#3                    // colsA = 3
    mov x3,#3                    // rowsB = 3
    mov x4,#2                    // colsB = 2
    cmp x2,x3                    // colsA == rowsB ?
    b.ne mul_fail                // error si no son compatibles

    /* Preparar bases de las matrices */
    adr x10,matrix_a             // base de A
    adr x11,matrix_b             // base de B
    adr x12,matrix_c             // base de C
    mov x13,#0                   // i = 0

mul_i_loop:
    cmp x13,x1                   // i < rowsA ?
    b.eq mul_validate            // terminar al procesar filas
    mov x14,#0                   // j = 0

mul_j_loop:
    cmp x14,x4                   // j < colsB ?
    b.eq mul_next_i              // pasar a la siguiente fila
    mov x15,#0                   // acumulador = 0 para C[i][j]
    mov x16,#0                   // k = 0

mul_k_loop:
    cmp x16,x2                   // k < colsA ?
    b.eq mul_store_c             // terminar acumulacion para C[i][j]

    /* Leer A[i][k] en row-major */
    mul x17,x13,x2               // i * colsA
    add x17,x17,x16              // indice lineal de A[i][k]
    lsl x17,x17,#3               // offset en bytes
    add x5,x10,x17               // direccion de A[i][k]
    ldr x6,[x5]                  // cargar A[i][k]

    /* Leer B[k][j] en row-major */
    mul x17,x16,x4               // k * colsB
    add x17,x17,x14              // indice lineal de B[k][j]
    lsl x17,x17,#3               // offset en bytes
    add x7,x11,x17               // direccion de B[k][j]
    ldr x8,[x7]                  // cargar B[k][j]

    /* Acumular producto parcial */
    mul x9,x6,x8                 // A[i][k] * B[k][j]
    add x15,x15,x9               // acumulador += producto
    add x16,x16,#1               // k++
    b mul_k_loop                 // repetir eje comun

mul_store_c:
    /* Guardar C[i][j] cuando termina el loop k */
    mul x17,x13,x4               // i * colsB
    add x17,x17,x14              // indice lineal de C[i][j]
    lsl x17,x17,#3               // offset en bytes
    add x5,x12,x17               // direccion de C[i][j]
    str x15,[x5]                 // guardar acumulador
    add x14,x14,#1               // j++
    b mul_j_loop                 // repetir columnas

mul_next_i:
    add x13,x13,#1               // i++
    b mul_i_loop                 // repetir filas

mul_validate:
    /* Comparar la matriz calculada con la matriz esperada */
    adr x10,matrix_expected      // base de matriz esperada
    adr x12,matrix_c             // base de matriz calculada
    mov x13,#0                   // indice lineal = 0

mul_validate_loop:
    cmp x13,#4                   // 4 elementos en C
    b.eq mul_success             // todo correcto
    lsl x17,x13,#3               // offset en bytes
    add x5,x12,x17               // direccion C[k]
    ldr x6,[x5]                  // leer C[k]
    add x7,x10,x17               // direccion EXPECTED[k]
    ldr x8,[x7]                  // leer EXPECTED[k]
    cmp x6,x8                    // comparar resultado con esperado
    b.ne mul_fail                // error si no coincide
    add x13,x13,#1               // k++
    b mul_validate_loop          // repetir validacion

mul_success:
    mov x0,#0                    // exito
    ret                          // volver al llamador

mul_fail:
    mov x0,#1                    // codigo de error
    ret                          // volver al llamador
