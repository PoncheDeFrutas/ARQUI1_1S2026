# Requisitos del Sistema

## 1. Estructura general del sistema

El sistema debe funcionar desde consola y comenzar con una pantalla de bienvenida. Después, debe mostrar un menú principal que permita administrar matrices y ejecutar operaciones sobre ellas.

La idea es que el programa no trabaje solo con una matriz temporal, sino que permita guardar matrices en memoria para reutilizarlas en distintas operaciones.

---

## 2. Flujo general

1. Mostrar bienvenida
2. Mostrar menú principal
3. Permitir crear o registrar matrices
4. Permitir editar, eliminar o consultar matrices guardadas
5. Permitir seleccionar matrices para operar
6. Mostrar resultados en consola
7. Volver al menú principal hasta que el usuario decida salir

---

## 3. Menú principal

El menú principal puede tener opciones como estas:

### 3.1 Crear o guardar una matriz

Permite ingresar una nueva matriz y almacenarla en memoria.

#### Debe pedir:

* Identificador o nombre de la matriz
* Número de filas
* Número de columnas
* Valores de cada posición

#### Formato de ingreso:

```text
a[i][j] = valor
```

#### Consideraciones:

* Reservar memoria dinámica para la matriz
* Guardar dimensiones
* Guardar puntero o referencia a la matriz
* Almacenar los datos en formato row-major

---

### 3.2 Ver matrices guardadas

Permite listar las matrices que existen actualmente en memoria.

#### Debe mostrar:

* Nombre o identificador
* Número de filas
* Número de columnas
* Estado de la matriz

Esto sirve para que el usuario sepa qué matrices puede usar en operaciones.

---

### 3.3 Mostrar una matriz

Permite seleccionar una matriz guardada e imprimirla en consola.

#### Requiere:

* Seleccionar una sola matriz

---

### 3.4 Editar datos de una matriz

Permite modificar una matriz ya guardada.

#### Puede incluir:

* Cambiar un valor específico
* Reingresar todos los valores
* Cambiar dimensiones solo si se libera y se vuelve a reservar memoria

#### Restricciones:

* Si cambian filas o columnas, no basta con cambiar el dato; debe reconstruirse la matriz
* Si solo cambian valores, se mantiene la misma estructura

---

### 3.5 Liberar una matriz

Permite eliminar una matriz guardada y liberar la memoria dinámica asociada.

#### Requiere:

* Seleccionar una sola matriz

#### Debe hacer:

* Liberar memoria
* Eliminar su referencia del sistema
* Evitar que vuelva a usarse después de ser eliminada

---

### 3.6 Liberar todas las matrices

Permite limpiar toda la memoria utilizada por el sistema.

#### Debe hacer:

* Liberar todas las matrices almacenadas
* Reiniciar la estructura de control de matrices

---

### 3.7 Operar matrices

Permite entrar a un submenú de operaciones matemáticas y algebraicas.

---

### 3.8 Salir

Antes de salir, el sistema debe liberar toda la memoria usada.

---

## 4. Entrada de datos

Cada vez que se cree una matriz, el sistema debe pedir:

* Número de filas (m)
* Número de columnas (n)
* Valor de cada elemento

#### Formato:

```text
a[i][j] = valor
```

#### Consideraciones:

* Reservar memoria dinámica para m x n elementos
* Almacenar en row-major
* Permitir acceso por índices A[i][j]

---

## 5. Submenú de operaciones

Las operaciones deben trabajar sobre matrices ya guardadas.

El sistema debe pedir qué matriz o matrices se van a usar según la operación.

---

## 6. Operaciones del sistema

### 6.1 Matriz identidad

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricción:

  * Debe ser cuadrada
* Resultado:

  * Puede reemplazar la matriz actual o generar una nueva matriz identidad

---

### 6.2 Matriz transpuesta

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricción:

  * Ninguna
* Resultado:

  * Puede mostrarse o guardarse como una nueva matriz

---

### 6.3 Método de Gauss

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricción:

  * Debe poder aplicarse eliminación sin errores de pivote
* Resultado:

  * Matriz triangular superior

---

### 6.4 Método de Gauss-Jordan

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricción:

  * Debe evitar división por cero en pivotes
* Resultado:

  * Matriz reducida por filas

---

### 6.5 Matriz inversa

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricciones:

  * Debe ser cuadrada
  * Debe ser invertible
  * Determinante distinto de 0
* Resultado:

  * Nueva matriz inversa o impresión en consola

---

### 6.6 Determinante

* Tipo: 1 matriz
* Usa: una matriz existente
* Restricción:

  * Debe ser cuadrada
* Resultado:

  * Valor escalar

---

### 6.7 Suma

* Tipo: 2 matrices
* Usa: dos matrices guardadas
* Restricción:

  * Deben tener las mismas dimensiones
* Resultado:

  * Nueva matriz resultado o impresión en consola

---

### 6.8 Resta

* Tipo: 2 matrices
* Usa: dos matrices guardadas
* Restricción:

  * Deben tener las mismas dimensiones
* Resultado:

  * Nueva matriz resultado o impresión en consola

---

### 6.9 Multiplicación

* Tipo: 2 matrices
* Usa: dos matrices guardadas
* Restricción:

  * El número de columnas de A debe ser igual al número de filas de B
* Resultado:

  * Nueva matriz resultado o impresión en consola

---

### 6.10 División

* Tipo: 2 matrices
* Usa: dos matrices guardadas
* Restricciones:

  * La segunda matriz debe ser cuadrada
  * La segunda matriz debe ser invertible
  * Se interpreta como A × B⁻¹
* Resultado:

  * Nueva matriz resultado o impresión en consola

---

## 7. Validaciones generales

El sistema debe validar lo siguiente:

* Que la matriz exista antes de usarla
* Que no se use una matriz liberada
* Que las dimensiones sean compatibles
* Que las operaciones que requieren matriz cuadrada lo verifiquen antes de ejecutarse
* Que no haya divisiones por cero en Gauss, Gauss-Jordan o inversa
* Que haya memoria disponible al crear matrices
* Que los nombres o identificadores no generen conflicto

---

## 8. Estructura lógica sugerida

El sistema tiene más sentido si maneja una tabla o registro de matrices guardadas.

Cada matriz podría tener:

* Identificador o nombre
* Filas
* Columnas
* Dirección base en memoria
* Estado: activa o liberada

Esto permite que el usuario cree varias matrices y luego elija cuáles usar en cada operación.

---

## 9. Resultado esperado

El sistema debe sentirse como un administrador básico de matrices.

No solo debe calcular, sino también:

* Crear matrices
* Guardarlas
* Consultarlas
* Modificarlas
* Eliminarlas
* Reutilizarlas en operaciones

Así el proyecto tiene una lógica completa y no solo una ejecución aislada de cálculos.
