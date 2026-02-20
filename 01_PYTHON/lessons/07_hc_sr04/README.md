# Leccion 07: Sensor ultrasonico HC-SR04 (distancia)

Esta leccion muestra como medir distancia con el HC-SR04 usando GPIO en Raspberry Pi.

## Objetivos

- Enviar el pulso TRIG y leer el pulso ECHO.
- Calcular distancia en centimetros.
- Evitar bloqueos con timeouts simples.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Sensor HC-SR04.
- Resistencias para divisor de voltaje en ECHO (recomendado).

## Conexion (modo BCM)

HC-SR04:

- VCC -> 5V
- GND -> GND
- TRIG -> GPIO23 (pin fisico 16)
- ECHO -> GPIO24 (pin fisico 18) **con divisor de voltaje a 3.3V**

> ECHO del HC-SR04 es 5V. Usa divisor (por ejemplo 1k/2k o 1k/1.8k) para proteger el GPIO.

## Como funciona

- TRIG se pone HIGH por 10 microsegundos.
- El sensor emite ultrasonido y ECHO se mantiene HIGH mientras espera el retorno.
- El tiempo de ECHO permite calcular distancia.

## Archivos de la leccion

- `hc_sr04_distance.py`: medicion continua con promedio simple.

## Como ejecutar

```bash
python3 hc_sr04_distance.py
```

Deten con `Ctrl+C`.

## Que puedes modificar

- Pines TRIG/ECHO si usas otros.
- Intervalo entre mediciones.
- Numero de lecturas para promedio.

## Errores comunes

- Conectar ECHO directo a 5V (riesgo de dano).
- No usar GND comun.
- Objetos muy cercanos (<2 cm) o muy lejanos (>400 cm).
