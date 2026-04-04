/* =========================================================
 * Leccion 15 - Operaciones con matrices en ARM64 (Linux)
 * Archivo: matrix_ops_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos de suma, resta y escalar.
 * ========================================================= */

/* Registros usados
 * x0  = codigo de retorno
 * x1  = base de matriz A o filas
 * x2  = base de matriz B o columnas
 * x3  = base de matriz resultado o filas/columnas de comparacion
 * x4  = indice i o valor escalar
 * x5  = indice j o indice lineal
 * x6  = numero de columnas
 * x7  = offset en bytes
 * x8  = direccion temporal
 * x9  = valor leido de A
 * x10 = valor leido de B
 * x11 = valor calculado
 * x12 = base de matriz esperada
 * x13 = indice de validacion
 * x14 = direccion temporal
 * x15 = valor temporal
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
mat_sum_a:        .quad 1, 2, 3, 4
mat_sum_b:        .quad 10, 20, 30, 40
mat_sum_out:      .quad 0, 0, 0, 0
mat_sum_expected: .quad 11, 22, 33, 44

mat_sub_a:        .quad 9, 8, 7, 6
mat_sub_b:        .quad 1, 2, 3, 4
mat_sub_out:      .quad 0, 0, 0, 0
mat_sub_expected: .quad 8, 6, 4, 2

mat_scalar_in:       .quad 1, 2, 3, 4
mat_scalar_out:      .quad 0, 0, 0, 0
mat_scalar_expected: .quad 3, 6, 9, 12

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_matrix_sum
.global demo_matrix_sub
.global demo_matrix_scalar
.global demo_matrix_dim_check

demo_matrix_sum:
    /* Recorrer dos matrices 2x2 y sumar elemento a elemento */
    adr x1,mat_sum_a             // base de A
    adr x2,mat_sum_b             // base de B
    adr x3,mat_sum_out           // base de salida
    mov x4,#0                    // i = 0

sum_row_loop:
    cmp x4,#2                    // rows = 2
    b.eq sum_validate            // terminar al procesar filas
    mov x5,#0                    // j = 0

sum_col_loop:
    cmp x5,#2                    // cols = 2
    b.eq sum_next_row            // pasar a la siguiente fila
    mov x6,#2                    // cols = 2
    mul x7,x4,x6                 // i * cols
    add x7,x7,x5                 // indice lineal = i*cols + j
    lsl x7,x7,#3                 // offset en bytes
    add x8,x1,x7                 // direccion A[i][j]
    ldr x9,[x8]                  // leer A[i][j]
    add x8,x2,x7                 // direccion B[i][j]
    ldr x10,[x8]                 // leer B[i][j]
    add x11,x9,x10               // A[i][j] + B[i][j]
    add x8,x3,x7                 // direccion OUT[i][j]
    str x11,[x8]                 // guardar resultado
    add x5,x5,#1                 // j++
    b sum_col_loop               // repetir columnas

sum_next_row:
    add x4,x4,#1                 // i++
    b sum_row_loop               // repetir filas

sum_validate:
    adr x12,mat_sum_expected     // matriz esperada
    mov x13,#0                   // indice lineal = 0

sum_validate_loop:
    cmp x13,#4                   // 4 elementos
    b.eq demo_success            // todo correcto
    lsl x14,x13,#3               // offset en bytes
    add x8,x3,x14                // direccion OUT[k]
    ldr x9,[x8]                  // leer resultado
    add x8,x12,x14               // direccion EXPECTED[k]
    ldr x10,[x8]                 // leer esperado
    cmp x9,x10                   // comparar resultado y esperado
    b.ne demo_fail               // error si no coincide
    add x13,x13,#1               // k++
    b sum_validate_loop          // repetir validacion

demo_matrix_sub:
    /* Recorrer dos matrices 2x2 y restar elemento a elemento */
    adr x1,mat_sub_a             // base de A
    adr x2,mat_sub_b             // base de B
    adr x3,mat_sub_out           // base de salida
    mov x4,#0                    // i = 0

sub_row_loop:
    cmp x4,#2                    // rows = 2
    b.eq sub_validate            // terminar al procesar filas
    mov x5,#0                    // j = 0

sub_col_loop:
    cmp x5,#2                    // cols = 2
    b.eq sub_next_row            // pasar a la siguiente fila
    mov x6,#2                    // cols = 2
    mul x7,x4,x6                 // i * cols
    add x7,x7,x5                 // indice lineal = i*cols + j
    lsl x7,x7,#3                 // offset en bytes
    add x8,x1,x7                 // direccion A[i][j]
    ldr x9,[x8]                  // leer A[i][j]
    add x8,x2,x7                 // direccion B[i][j]
    ldr x10,[x8]                 // leer B[i][j]
    sub x11,x9,x10               // A[i][j] - B[i][j]
    add x8,x3,x7                 // direccion OUT[i][j]
    str x11,[x8]                 // guardar resultado
    add x5,x5,#1                 // j++
    b sub_col_loop               // repetir columnas

sub_next_row:
    add x4,x4,#1                 // i++
    b sub_row_loop               // repetir filas

sub_validate:
    adr x12,mat_sub_expected     // matriz esperada
    mov x13,#0                   // indice lineal = 0

sub_validate_loop:
    cmp x13,#4                   // 4 elementos
    b.eq demo_success            // todo correcto
    lsl x14,x13,#3               // offset en bytes
    add x8,x3,x14                // direccion OUT[k]
    ldr x9,[x8]                  // leer resultado
    add x8,x12,x14               // direccion EXPECTED[k]
    ldr x10,[x8]                 // leer esperado
    cmp x9,x10                   // comparar resultado y esperado
    b.ne demo_fail               // error si no coincide
    add x13,x13,#1               // k++
    b sub_validate_loop          // repetir validacion

demo_matrix_scalar:
    /* Recorrer una matriz 2x2 y multiplicar cada celda por 3 */
    adr x1,mat_scalar_in         // base de entrada
    adr x3,mat_scalar_out        // base de salida
    mov x4,#0                    // i = 0
    mov x15,#3                   // escalar = 3

scalar_row_loop:
    cmp x4,#2                    // rows = 2
    b.eq scalar_validate         // terminar al procesar filas
    mov x5,#0                    // j = 0

scalar_col_loop:
    cmp x5,#2                    // cols = 2
    b.eq scalar_next_row         // pasar a la siguiente fila
    mov x6,#2                    // cols = 2
    mul x7,x4,x6                 // i * cols
    add x7,x7,x5                 // indice lineal = i*cols + j
    lsl x7,x7,#3                 // offset en bytes
    add x8,x1,x7                 // direccion IN[i][j]
    ldr x9,[x8]                  // leer IN[i][j]
    mul x11,x9,x15               // IN[i][j] * escalar
    add x8,x3,x7                 // direccion OUT[i][j]
    str x11,[x8]                 // guardar resultado
    add x5,x5,#1                 // j++
    b scalar_col_loop            // repetir columnas

scalar_next_row:
    add x4,x4,#1                 // i++
    b scalar_row_loop            // repetir filas

scalar_validate:
    adr x12,mat_scalar_expected  // matriz esperada
    mov x13,#0                   // indice lineal = 0

scalar_validate_loop:
    cmp x13,#4                   // 4 elementos
    b.eq demo_success            // todo correcto
    lsl x14,x13,#3               // offset en bytes
    add x8,x3,x14                // direccion OUT[k]
    ldr x9,[x8]                  // leer resultado
    add x8,x12,x14               // direccion EXPECTED[k]
    ldr x10,[x8]                 // leer esperado
    cmp x9,x10                   // comparar resultado y esperado
    b.ne demo_fail               // error si no coincide
    add x13,x13,#1               // k++
    b scalar_validate_loop       // repetir validacion

demo_matrix_dim_check:
    /* Validar que 2x2 y 2x3 no son compatibles para suma/resta */
    mov x1,#2                    // rows_a = 2
    mov x2,#2                    // cols_a = 2
    mov x3,#2                    // rows_b = 2
    mov x4,#3                    // cols_b = 3
    cmp x1,x3                    // rows_a == rows_b ?
    b.ne dim_incompatible        // si no, incompatibles
    cmp x2,x4                    // cols_a == cols_b ?
    b.ne dim_incompatible        // si no, incompatibles
    b demo_fail                  // seria error considerarlas validas

dim_incompatible:
    mov x0,#0                    // exito: incompatibilidad detectada
    ret                          // volver al llamador

demo_success:
    mov x0,#0                    // exito
    ret                          // volver al llamador

demo_fail:
    mov x0,#1                    // codigo de error
    ret                          // volver al llamador
