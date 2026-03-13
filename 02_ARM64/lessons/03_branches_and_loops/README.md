# Leccion 03 - Branches y loops

## Objetivo de aprendizaje

Construir un ciclo controlado por comparaciones y saltos condicionales para acumular resultados en registros.

## Prerrequisitos

- Haber completado `../02_alu_and_flags/README.md`.
- Entender `cmp`, `b.eq` y codigo de salida por syscall `exit`.
- Entorno de depuracion disponible.

## Conceptos nuevos (3-5 maximo)

- Branches incondicionales y condicionales (`b`, `b.le`).
- Estructura de loop con contador.
- Acumulador en registro.
- Validacion de resultado al final del ciclo.

## Archivos de la leccion

```text
lessons/03_branches_and_loops/
|- README.md
|- main.s
`- Makefile
```

## Flujo de trabajo

Desde el directorio de la leccion:

```bash
make
make run
make gdb
```

## Salida esperada

El programa no imprime texto y finaliza con codigo `0` cuando la suma de `1..5` es correcta.

## Verificacion (checklist)

- `build/main` se genera sin error.
- En GDB observas que `x1` avanza de 1 a 5.
- En GDB observas que `x2` termina en `15`.
- El branch condicional del loop deja de repetirse cuando `x1 > 5`.

## Errores comunes

- Inicializar mal contador o acumulador.
- Usar condicion incorrecta del loop (`b.lt`, `b.ge`, etc.).
- Olvidar incrementar el contador y quedar en loop infinito.

## Ejercicios propuestos

1. Cambia el rango para sumar `1..10`.
2. Implementa suma de solo numeros pares.
3. Crea un loop descendente de `5..1` y verifica mismo resultado.

## Criterios de evaluacion sugeridos

- **Correctitud:** resultado final correcto para el rango definido.
- **Control de flujo:** loop termina cuando corresponde.
- **Depuracion:** evidencia de analisis de contador y acumulador.

## Proxima leccion

- [Leccion 04 - Memoria, load y store](../04_memory_load_store/README.md)
