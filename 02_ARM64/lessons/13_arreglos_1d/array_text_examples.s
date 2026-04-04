/* =========================================================
 * Leccion 13 - Arreglos 1D en ARM64 (Linux)
 * Archivo: array_text_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene demos con texto ASCII.
 * ========================================================= */

/* Registros usados
 * x0 = codigo de retorno
 * x1 = direccion base del texto
 * w2 = caracter objetivo
 * x3 = indice i
 * x4 = contador de coincidencias
 * w5 = byte actual del texto
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
word_banana: .asciz "banana"     // string de prueba

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global demo_count_char

demo_count_char:
    /* Contar cuantas veces aparece 'a' en "banana" */
    adr x1,word_banana           // base del string
    mov w2,#'a'                  // caracter objetivo
    mov x3,#0                    // indice i = 0
    mov x4,#0                    // contador = 0

count_loop:
    ldrb w5,[x1,x3]              // leer byte actual
    cbz w5,count_validate        // fin del string?
    cmp w5,w2                    // comparar con 'a'
    b.ne count_next              // si no coincide, avanzar
    add x4,x4,#1                 // contador++

count_next:
    add x3,x3,#1                 // i++
    b count_loop                 // repetir

count_validate:
    cmp x4,#3                    // "banana" tiene 3 letras 'a'
    b.ne count_fail              // error si no coincide
    mov x0,#0                    // exito
    ret                          // volver al llamador

count_fail:
    mov x0,#1                    // codigo de error
    ret                          // volver al llamador
