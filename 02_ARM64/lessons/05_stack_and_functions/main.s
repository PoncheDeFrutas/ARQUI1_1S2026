/* =========================================================
 * Leccion 05 - Stack y funciones en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * Objetivo: aplicar prologo/epilogo y llamada a funcion.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0  = argumento de funcion y valor de retorno
 * x8  = numero de syscall Linux ARM64
 * x19 = copia local de n dentro de la funcion (callee-saved)
 * x20 = acumulador local dentro de la funcion (callee-saved)
 * x29 = frame pointer (fp) su funcion es guardar el valor anterior de fp
 *     y servir como referencia para acceder a variables locales.
 * x30 = link register (lr) su funcion es guardar la direccion de retorno de la funcion.
 * sp  = stack pointer
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no necesita datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * 1) Preparar argumento y llamar funcion
     * -----------------------------------------------------
     * Queremos calcular suma_1_a_n(5) = 15.
     * ABI AArch64:
     *   x0 = argumento 1
     *   x0 = valor de retorno
     * ----------------------------------------------------- */

    mov     x0, #5               // n = 5
    bl      suma_1_a_n           // x30 = retorno, x0 = 15 al volver

    /* -----------------------------------------------------
     * 2) Validar retorno de la funcion
     * ----------------------------------------------------- */
    cmp     x0, #15
    b.eq    ok

error:
    /* -----------------------------------------------------
     * Rama de error: retorno inesperado de la funcion
     * ----------------------------------------------------- */
    mov     x0, #1               // codigo de error
    b       exit_program

ok:
    /* -----------------------------------------------------
     * Rama de exito: retorno correcto de la funcion
     * ----------------------------------------------------- */
    mov     x0, #0               // codigo de exito

exit_program:
    /* -----------------------------------------------------
     * syscall: exit(x0)
     *
     * x0 = codigo de salida
     * x8 = numero de syscall (93)
     * ----------------------------------------------------- */
    mov     x8, #93              // syscall exit
    svc     #0                   // llamada al kernel


suma_1_a_n:
    /* -----------------------------------------------------
     * Funcion: suma_1_a_n(n)
     *
     * Entrada:
     *   x0 = n
     * Salida:
     *   x0 = 1 + 2 + ... + n
     * ----------------------------------------------------- */

    /* -----------------------------------------------------
     * 3) Prologo de funcion
     * -----------------------------------------------------
     * Objetivo del prologo:
     * - Preservar contexto del llamador.
     * - Crear un frame estable para esta funcion.
     *
     * Paso A) Guardar fp/lr previos y reservar 16 bytes:
     *   stp x29, x30, [sp, #-16]!
     *   - decrementa sp en 16
     *   - guarda x29 (fp viejo) y x30 (direccion retorno)
     *
     * Paso B) Definir fp del frame actual:
     *   Esta funcion usara x29 como frame pointer, que es un registro callee-saved.
     *   El frame pointer es un puntero fijo dentro del stack frame de esta funcion,
     *   que se puede usar para acceder a variables locales y argumentos.
     *   En este caso, simplemente lo igualamos al valor actual de sp,
     *   que apunta al inicio del frame de esta funcion.
     *   mov x29, sp
     *
     * Paso C) Guardar callee-saved que modificaremos:
     *   stp x19, x20, [sp, #-16]!
     *   - decrementa sp en 16
     *   - guarda x19/x20 originales
     *
     * Layout despues del prologo (direccion alta -> baja):
     *   [x29 viejo]
     *   [x30 viejo]
     *   [x19 viejo]
     *   [x20 viejo] <- sp actual
     * ----------------------------------------------------- */
    stp     x29, x30, [sp, #-16]!    // push fp/lr y actualizar sp
    mov     x29, sp                  // nuevo frame pointer
    stp     x19, x20, [sp, #-16]!    // push x19/x20 y actualizar sp

    /* -----------------------------------------------------
     * 4) Inicializar variables locales en registros
     * ----------------------------------------------------- */
    mov     x19, x0              // x19 = n (contador)
    mov     x20, #0              // x20 = acumulador

loop_sum:
    /* -----------------------------------------------------
     * 5) while (x19 > 0) { x20 += x19; x19--; }
     *
     * x19 = contador n..1
     * x20 = acumulador de la suma
     * ----------------------------------------------------- */
    cmp     x19, #0
    b.le    end_sum
    add     x20, x20, x19
    sub     x19, x19, #1
    b       loop_sum

end_sum:
    /* -----------------------------------------------------
     * 6) Preparar retorno y restaurar contexto
     * -----------------------------------------------------
     * Epilogo (inverso al prologo):
     * - mover retorno a x0
     * - restaurar x19/x20
     * - restaurar x29/x30
     * - ret usa x30 para volver al llamador
     * ----------------------------------------------------- */
    mov     x0, x20              // retorno en x0
    ldp     x19, x20, [sp], #16  // pop x19/x20
    ldp     x29, x30, [sp], #16  // pop fp/lr
    ret                          // volver a _start
