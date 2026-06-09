// 07_atoi_b.s
//
// Entrada:
//   x21 = puntero actual dentro del buffer
//   x5  = base 10
//
// Salida:
//   x10 = numero convertido
//   x7  = 1 si leyo al menos un digito
//   w23 = delimitador encontrado

atoi_csv:
    mov x10, #0             // resultado = 0
    mov x7, #0              // bandera de numero activo

atoi_loop:
    ldrb w23, [x21], #1

    // si encuentra coma, termina
    cmp w23, ','
    beq atoi_done

    // si encuentra salto de linea, termina
    cmp w23, #10
    beq atoi_done

    // si encuentra $, termina
    cmp w23, '$'
    beq atoi_done

    // verificar si es digito
    cmp w23, '0'
    blt atoi_loop

    cmp w23, '9'
    bgt atoi_loop

    // convertir ASCII a numero
    sub w23, w23, '0'

    // resultado = resultado * 10
    mov x4, x10
    mul x10, x4, x5

    // resultado = resultado + digito
    add x10, x10, x23

    // marcar numero activo
    mov x7, #1

    b atoi_loop

atoi_done:
    ret
