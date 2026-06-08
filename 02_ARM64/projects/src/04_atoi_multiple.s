.data

input_number:
    .asciz "320,150,28,30$"

.text

.global _start

_start:
    mov x1, #0              // resultado = 0
    ldr x0, =input_number   // cargar la dirección de la cadena de entrada
    mov x5, #10             // base = 10


read_loop:
    // lectura del caracter en x0, e incremento el puntero
    ldrb w3, [x0], #1

    cmp w3, '$'
    beq atoi_done

    cmp w3, ','
    beq number_done

    // verificar si el caracter es un dígito
    cmp w3, '0'
    blt atoi_done

    cmp w3, '9'
    bgt atoi_done

    sub w3, w3, '0'        // convertir el caracter a su valor numérico
    mov x4, x1             // resultado actual en w4
    mul x1, x4, x5         // resultado = resultado * base
    add x1, x1, x3         // resultado = resultado + valor del dí

    b read_loop            // repetir el proceso para el siguiente caracter

number_done:
    // MANUPILAR EL DATO
    mov x1, #0              // reiniciar resultado para el siguiente número
    b read_loop             // continuar leyendo el siguiente número

atoi_done:

    mov x0, x1              // mover el resultado a x0 para la salida
    mov x8, #83             // syscall number for exit
    svc #0                  // llamada al sistema para salir
