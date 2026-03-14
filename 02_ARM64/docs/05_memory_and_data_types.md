# Memoria y tipos de datos en ARM64

Este documento establece los conceptos de memoria que deben dominarse antes de trabajar con matrices y MMIO.

## 1) Modelo de memoria minimo del curso

- `.text`: instrucciones.
- `.data`: datos inicializados.
- `.bss`: datos no inicializados.
- stack: datos temporales y contexto de funciones.

## 2) Tamano de dato y accesos

- 8 bits: `ldrb` / `strb`
- 16 bits: `ldrh` / `strh`
- 32 bits: `ldr wN` / `str wN`
- 64 bits: `ldr xN` / `str xN`

Regla practica: el tipo de dato define la instruccion de carga/almacenamiento.

## 3) Alineacion

- Accesos de 32 bits idealmente alineados a 4 bytes.
- Accesos de 64 bits idealmente alineados a 8 bytes.
- Mala alineacion puede degradar rendimiento y complicar depuracion.

## 4) Signo, cero y extension

Casos tipicos:

- Cargar byte sin signo -> extender con cero.
- Cargar byte con signo -> extender con signo.
- Mezclar operaciones de 32/64 bits requiere control explicito de extension.

Errores comunes:

- Tratar un dato firmado como no firmado.
- Sobrescribir registros por usar `wN` cuando se esperaba conservar `xN`.

## 5) Punteros y aritmetica de direcciones

Patron general para arreglo lineal:

`direccion = base + indice * tamano_elemento`

En ARM64, suele hacerse con `add` y desplazamientos (`lsl`) cuando el tamano es potencia de 2.

## 6) Stack y funciones

- `sp` debe mantenerse consistente.
- Si una funcion usa registros callee-saved, debe preservarlos y restaurarlos.
- Usa un prologo/epilogo claro cuando la leccion ya introdujo ABI.

## 7) Verificacion sugerida en laboratorio

- Inspeccionar memoria con GDB antes y despues de una rutina.
- Verificar offsets esperados para diferentes tamanos de dato.
- Probar con casos borde (0, maximos, negativos).

## 8) Ejemplo visual: como se guarda y se lee en memoria

Supongamos este bloque en `.data`:

```asm
a:      .quad 10
b:      .quad 20
result: .quad 0
```

Layout en memoria (64 bits por elemento):

```text
base = &a

base + 0   -> a
base + 8   -> b
base + 16  -> result
```

Accesos tipicos:

```asm
adr x10, a            // x10 = direccion base
ldr x1, [x10, #0]     // lee a
ldr x2, [x10, #8]     // lee b
add x3, x1, x2        // x3 = 30
str x3, [x10, #16]    // guarda result
```

Formula general para offsets:

`offset = indice * tamano_elemento`

- Si el tipo es de 8 bytes -> offsets: `0, 8, 16, 24, ...`
- Si el tipo es de 4 bytes -> offsets: `0, 4, 8, 12, ...`

Comando GDB sugerido para visualizar el bloque:

```gdb
x/3gx $x10
```

Interpretacion:

- primer valor: `a`
- segundo valor: `b`
- tercer valor: `result`
