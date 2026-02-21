# Leccion 08: Sensor de color TCS3200 (Raspberry Pi)

Esta leccion muestra como leer un sensor TCS3200 usando GPIO. Se mide la frecuencia de salida para cada filtro de color (R, G, B) y se calcula un valor relativo.

## Objetivos

- Configurar los pines de control S0–S3 y leer OUT.
- Medir frecuencia de salida para cada color.
- Calcular valores relativos (normalizados) para comparar colores.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Sensor TCS3200.
- Resistencias para divisor de voltaje en OUT (recomendado).

## Conexion (modo BCM)

TCS3200 (modulo tipico):

- VCC -> 5V
- GND -> GND
- S0  -> GPIO17
- S1  -> GPIO27
- S2  -> GPIO22
- S3  -> GPIO23
- OUT -> GPIO24 **con divisor a 3.3V**
- OE  -> GND (habilita salida)

> OUT suele ser 5V. Usa divisor de voltaje para proteger el GPIO.

## Como funciona

- S2 y S3 seleccionan el filtro: rojo, verde, azul o sin filtro.
- S0 y S1 seleccionan el escalado de frecuencia (100%, 20%, 2%, apagado).
- OUT entrega una onda cuadrada con frecuencia proporcional a la intensidad del color filtrado.

## Archivos de la leccion

- `tcs3200_basic.py`: lectura de frecuencia y valores normalizados.

## Como ejecutar

```bash
python3 tcs3200_basic.py
```

Deten con `Ctrl+C`.

## Calibracion basica

- Asegura iluminacion constante.
- Coloca una superficie blanca y toma lecturas de R, G, B.
- Usa esas lecturas como referencia para normalizar lecturas futuras.

## Que puedes modificar

- Pines S0–S3 y OUT.
- Escalado de frecuencia (S0/S1).
- Tiempo de muestreo (duracion para contar pulsos).

## Errores comunes

- No usar divisor en OUT.
- Cambiar la iluminacion entre lecturas.
- Objetos muy cerca o muy lejos del sensor.
