.data

array:
    .quad 0, 0, 0, 0, 0

cantidad:
    .quad 0

.text
.global _start

_start:
    mov x20, #1 // dato inicial, o contador inicial
    mov x21, #10 // cantidad de datos a guardar
    mov x22, #0 // contador

// ESTE LOOP ES REEMPLAZABLE
// LOGICA DE EJEMPLO, EL LOOP PUEDE SER EL MOTOR
loop:
    cmp x22, x21 // comparar contador con cantidad
    beq end_program

    mov x0, x20
    bl guardar_dato

    add x20, x20, #1 // incrementar dato
    add x22, x22, #1 // incrementar contador
    b loop

guardar_dato:
    ldr x1, =cantidad
    ldr x2, [x1]

desplazar_array:
    // SE PUEDE QUITAR LO SIGUIENTE
    // SE MANDA X3 ANTES DE HACER UN BL A GUARDAR DATO
    ldr x3, =array

    mov x5, #4      // cantidad de desplazamientos
    mov x6, x3      // donde es el destino o dato a sobre escribir
    add x7, x3, #8  // el dato que se va a mover, el origen

desplazar_array_loop:
    cmp x5, #0
    beq guardar_nuevo_dato

    // se toma primero y segundo
    // segundo se escribe en primero
    ldr x4, [x7], #8
    str x4, [x6], #8

    sub x5, x5, #1

    b desplazar_array_loop

guardar_nuevo_dato:
    str x0, [x3, #32]
    ret

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0
