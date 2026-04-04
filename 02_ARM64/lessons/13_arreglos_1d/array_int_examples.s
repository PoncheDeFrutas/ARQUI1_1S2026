/* =========================================================
 * Leccion 13 - Arreglos 1D en ARM64 (Linux)
 * Archivo: array_int_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos con arreglos de enteros.
 * ========================================================= */

/* Registros usados
 * x0  = codigo de retorno
 * x1  = direccion base del arreglo
 * x2  = indice o valor objetivo
 * x3  = offset o indice de loop
 * x4  = direccion calculada o valor leido
 * x5  = valor temporal
 * x6  = valor temporal de validacion
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
arr_read:    .quad 9876543210, 7, 9, 11           // demo de lectura por indice
arr_replace: .quad 5, 10, 15, 20         // demo de reemplazo
arr_search:  .quad 8, 12, 15, 21         // demo de busqueda

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_read_index
.global demo_replace_index
.global demo_linear_search

demo_read_index:
    /* Leer arr[2] usando base + indice * 8 */
    adr x1,arr_read               // base del arreglo
    mov x2,#2                     // indice i = 2
    lsl x3,x2,#3                  // offset = i * 8
    add x4,x1,x3                  // direccion de arr[2]
    ldr x5,[x4]                   // cargar arr[2]
    cmp x5,#9                     // validar valor esperado
    b.ne demo_fail                // error si no coincide
    mov x0,#0                     // exito
    ret                           // volver al llamador

demo_replace_index:
    /* Reemplazar arr[1] por 99 y validar releitura */
    adr x1,arr_replace            // base del arreglo
    mov x2,#1                     // indice i = 1
    lsl x3,x2,#3                  // offset = i * 8
    add x4,x1,x3                  // direccion de arr[1]
    mov x5,#99                    // nuevo valor
    str x5,[x4]                   // escribir arr[1] = 99
    ldr x6,[x4]                   // releer arr[1]
    cmp x6,#99                    // validar escritura
    b.ne demo_fail                // error si no coincide
    ldr x6,[x1]                   // releer arr[0]
    cmp x6,#5                     // validar vecino izquierdo
    b.ne demo_fail                // error si fue alterado
    ldr x6,[x1,#16]               // releer arr[2]
    cmp x6,#15                    // validar vecino derecho
    b.ne demo_fail                // error si fue alterado
    mov x0,#0                     // exito
    ret                           // volver al llamador

demo_linear_search:
    /* Buscar 15 y validar que aparece en la posicion 2 */
    adr x1,arr_search             // base del arreglo
    mov x2,#15                    // valor objetivo encontrado
    mov x3,#0                     // indice inicial

search_found_loop:
    cmp x3,#4                     // recorrer 4 elementos
    b.eq demo_fail                // no encontrar 15 seria error
    ldr x4,[x1,x3,lsl #3]         // leer arr[i]
    cmp x4,x2                     // comparar con objetivo
    b.eq search_found_validate    // encontrado
    add x3,x3,#1                  // i++
    b search_found_loop           // repetir

search_found_validate:
    cmp x3,#2                     // 15 debe estar en indice 2
    b.ne demo_fail                // error si no coincide

    /* Buscar 7 y validar el caso no encontrado */
    mov x2,#7                     // valor que no existe
    mov x3,#0                     // reiniciar indice

search_missing_loop:
    cmp x3,#4                     // llego al final?
    b.eq search_missing_ok        // no encontrado correctamente
    ldr x4,[x1,x3,lsl #3]         // leer arr[i]
    cmp x4,x2                     // comparar con objetivo
    b.eq demo_fail                // seria error encontrar 7
    add x3,x3,#1                  // i++
    b search_missing_loop         // repetir

search_missing_ok:
    mov x0,#0                     // exito
    ret                           // volver al llamador

demo_fail:
    mov x0,#1                     // codigo de error
    ret                           // volver al llamador
