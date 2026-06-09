.data

msg_no_arg:
    .ascii "No se proporcionó ningún argumento\n"
    msg_no_arg_len = . - msg_no_arg

newline:
    .ascii "\n"

.text
.global _start

_start:
    ldr x0, [sp]            // Cargar el primer argumento (argc)

    cmp x0, #2              // Verificar si argc es igual a 2
    blt no_argumento        // Si argc es menor que 2, saltar a no_argumento

    // arg[1] esta en [sp + 16]
    ldr x1, [sp, #16]      // Cargar el puntero al primer argumento (arg[1])
    mov x2, #0             // Inicializar el índice para recorrer el argumento


str_loop:
    ldrb w3, [x1, x2]      // Cargar el byte actual del argumento
    cmp w3, #0             // Verificar si es el byte nulo (fin de cadena)
    beq imprimir_argumento // Si es el byte nulo, saltar a imprimir_argumento
    add x2, x2, #1         // Incrementar el índice
    b str_loop             // Continuar el bucle

imprimir_argumento:
    // write(STDOUT, arg[1], x2)
    mov x0, #1              // STDOUT
    mov x1, x1              // arg[1]
    mov x2, x2              // longitud del argumento
    mov x8, #64             // syscall: write
    svc #0

    // exit(0)
    mov x0, #0
    mov x8, #93             // syscall: exit
    svc #0

no_argumento:
    // write(STDOUT, msg_no_arg, msg_no_arg_len)
    mov x0, #1              // STDOUT
    ldr x1, =msg_no_arg      // msg_no_arg
    mov x2, msg_no_arg_len  // msg_no_arg_len
    mov x8, #64             // syscall: write
    svc #0

    // Exit (0)
    mov x0, #0
    mov x8, #93             // syscall: exit
    svc #0
