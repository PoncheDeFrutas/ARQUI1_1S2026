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
- [Lección 05: Pantalla LCD I2C](05_lcd_i2c/README.md)
  Uso de pantalla LCD por I2C con `rpi_lcd`: texto, alineación y limpieza.
- [Lección 06: Pantalla OLED I2C](06_oled_i2c/README.md)
  Uso de pantalla OLED SSD1306 por I2C: texto, contador y pixeles.
- [Lección 07: Sensor ultrasonico HC-SR04](07_hc_sr04/README.md)
  Medicion de distancia con GPIO y calculo por tiempo de eco.
- [Lección 08: Sensor de color TCS3200](08_tcs3200/README.md)
  Lectura de frecuencia por filtros RGB y normalizacion basica.
- [Lección 09: MQTT (MQTTX)](09_mqttx/README.md)
  Conexion basica, publicar, suscribir y reconexion.

## ¿Cómo usar estas lecciones?

1. Entra a la carpeta de la lección.
2. Lee el `README.md` de la lección para entender el objetivo y la teoría básica.
3. Ejecuta los ejemplos con `python3`.

## Sugerencia

Puedes avanzar en orden, ya que cada lección parte de conceptos básicos y luego agrega nuevas ideas.
