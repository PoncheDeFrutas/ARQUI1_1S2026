# Arreglos y matrices en ARM64

Guia didactica para pasar de memoria lineal a operaciones matriciales en ensamblador.

## 1) Arreglos 1D

### Direccion de elemento

`addr(i) = base + i * elem_size`

### Patrones que se deben dominar

- Recorrido secuencial (`for i = 0..n-1`).
- Reducciones (`sum`, `min`, `max`).
- Transformaciones (`dst[i] = f(src[i])`).

## 2) Matrices 2D en memoria lineal (row-major)

### Direccion de elemento `(i, j)`

`addr(i, j) = base + ((i * cols) + j) * elem_size`

Conceptos clave:

- `rows`, `cols`, `stride`.
- Conversion 2D -> 1D.
- Validar limites para evitar desbordes de indice.

## 3) Orden recomendado de operaciones

1. Copia y lectura de matriz.
2. Suma y resta elemento a elemento.
3. Multiplicacion por escalar.
4. Transpuesta.
5. Multiplicacion de matrices (`C = A x B`).

## 4) Multiplicacion de matrices: enfoque pedagógico

Primero implementar version basica triple loop:

- `i`: fila de `A`
- `j`: columna de `B`
- `k`: acumulacion interna

Luego analizar:

- Reuso de datos en cache.
- Orden de loops y cantidad de accesos a memoria.
- Costos de direccionamiento repetido.

## 5) Tipos de datos en operaciones matriciales

- Comenzar con enteros de 32 bits.
- Extender a 16 bits y 8 bits para practicar extension de signo/cero.
- Introducir acumulador mas ancho cuando aplique (ej. sumar varios `int16` en `int32`).

## 6) Checklist por practica de matrices

- Formula de direccion documentada.
- Casos de prueba pequenos con resultado esperado manual.
- Casos de tamano no cuadrado (ej. 2x3 y 3x4).
- Verificacion de overflow en acumulaciones.

## 7) Conexion con IoT

Estas rutinas son base para:

- Filtrado de datos de sensores.
- Transformaciones numericas por bloques.
- Preprocesamiento antes de transmitir por red.
