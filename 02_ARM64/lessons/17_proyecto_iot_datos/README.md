# Leccion 17 - Proyecto IoT de datos

## Objetivo de aprendizaje

Integrar los conceptos del bloque ARM64 en un pipeline simple de datos estilo IoT: lectura de buffer, transformacion y salida validada.

## Prerrequisitos

- Haber completado `../16_multiplicacion_matrices_basica/README.md`.
- Dominar memoria, tipos, arreglos y matrices.

## Conceptos nuevos (3-5 maximo)

- Integracion de modulos y etapas.
- Flujo de datos por buffers.
- Verificacion end-to-end.

## Instrucciones y operaciones de esta leccion

| Instruccion/Operacion | Que hace | Que necesita | Para que sirve |
| --- | --- | --- | --- |
| `ldr/str` en buffers | Mueve datos entre etapas | Direcciones y offsets validos | Pipeline de datos |
| ALU/loops | Transforma muestras | Parametros de procesamiento | Filtrado/calculo |
| Funciones ABI | Separa etapas logicas | Convencion de llamada | Modularidad y pruebas |
| Syscalls de salida | Reporta estado/resultados | `write`/`exit` | Observabilidad del proyecto |

## Archivos de la leccion

```text
lessons/17_proyecto_iot_datos/
|- README.md
|- main.s                    (pendiente)
|- pipeline_examples.s       (pendiente)
|- data_models.s             (pendiente)
`- Makefile                  (pendiente)
```

## Estado actual

Leccion planificada como cierre del bloque ARM64.

## Estandar para archivos `.s`

Cada etapa del pipeline debe quedar documentada en codigo con comentarios de entrada, transformacion, salida y validacion.

## Flujo de trabajo

```bash
make
make run
make gdb
```

## Salida esperada

Resumen de ejecucion de pipeline y estado final `exit(0)` en caso correcto.

## Verificacion (checklist)

- Entrada -> transformacion -> salida sin corrupcion.
- Resultados finales coinciden con referencia.
- Manejo de errores por codigos de salida.

## Errores comunes

- Desalinear buffers entre etapas.
- No validar tamanos de entrada.
- Mezclar tipos signed/unsigned en transformaciones.

## Ejercicios propuestos

1. Agrega etapa de normalizacion simple.
2. Agrega checksum de salida.
3. Instrumenta tiempos de secciones con contadores basicos.

## Criterios de evaluacion sugeridos

- **Correctitud:** pipeline funcional end-to-end.
- **Integracion:** uso coherente de conceptos del curso.
- **Depuracion:** diagnostico claro de fallas por etapa.

## Proxima leccion

- Cierre del bloque ARM64 y transicion a practicas avanzadas IoT.
