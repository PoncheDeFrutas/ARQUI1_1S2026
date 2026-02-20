# Lecciones de Python (Raspberry Pi)

Este directorio contiene las lecciones prácticas de Python enfocadas en el uso de GPIO en Raspberry Pi. Cada lección incluye ejemplos y un README con la explicación básica del tema.

## Lecciones disponibles

- [Lección 00: Parpadeo y secuencia de LEDs](00_blink/README.md)
  Introducción al uso de `RPi.GPIO`, encendido/apagado de LEDs y secuencias simples.
- [Lección 01: Botón, antirrebote y eventos](01_input_button/README.md)
  Lectura de entradas digitales, pull-up/pull-down, antirrebote por software y callbacks.
- [Lección 02: PWM y control analógico simulado](02_pwm/README.md)
  Uso de PWM para brillo de LEDs, buzzer y servo; selección de frecuencia y duty.
- [Lección 03: Tareas periódicas y temporizadores](03_timers_tasks/README.md)
  Uso de hilos y timers para tareas en paralelo: heartbeat LED, sensor periódico y botón con callbacks.
- [Lección 04: Sensor DHT11](04_dht11/README.md)
  Lectura de temperatura y humedad con DHT11 usando `adafruit_dht`.

## ¿Cómo usar estas lecciones?

1. Entra a la carpeta de la lección.
2. Lee el `README.md` de la lección para entender el objetivo y la teoría básica.
3. Ejecuta los ejemplos con `python3`.

## Sugerencia

Puedes avanzar en orden, ya que cada lección parte de conceptos básicos y luego agrega nuevas ideas.
