# Lección 04: Sensor DHT11 (Raspberry Pi)

Esta lección muestra cómo leer un sensor DHT11 usando la librería `adafruit_dht`.

## Objetivos

- Leer temperatura y humedad con DHT11 en GPIO20.
- Manejar errores comunes de lectura (valores inválidos o excepciones).
- Respetar los tiempos mínimos entre lecturas del sensor.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Sensor DHT11.
- Resistencia de 10 kΩ (pull-up en la línea de datos).
- Cables y protoboard.

## Conexión (modo BCM)

DHT11 (3 pines):

- VCC -> 3.3V
- GND -> GND
- DATA -> GPIO20 (pin físico 38)
- Resistencia 10 kΩ entre VCC y DATA (pull-up)

> Nota: El DHT11 funciona a 3.3V. Evita 5V en los GPIO.

## Archivos de la lección

- `dht11_adafruit.py`: lectura usando `adafruit_dht`.
- `dht11_robust.py`: lectura con reintentos, último valor válido y reinicio si hay muchos errores.

## Instalación de librerías

Adafruit:

```bash
python3 -m pip install adafruit-circuitpython-dht
```

## Cómo ejecutar

Desde esta carpeta:

```bash
python3 dht11_adafruit.py
python3 dht11_robust.py
```

Detén con `Ctrl+C`.

## Qué puedes modificar

- GPIO de datos: cambia `GPIO20` si usas otro pin.
- Intervalo entre lecturas: el DHT11 requiere al menos 1-2 s.
- Formato de salida: imprime en una línea o agrega timestamp.
- Límite de errores: ajusta `max_errors` para reiniciar el sensor.

## Errores comunes

- Leer muy rápido (el DHT11 falla si consultas seguido).
- No usar resistencia pull-up en DATA.
- Cableado incorrecto de VCC/GND o confundir pines BCM/BOARD.
- Alimentar el DHT11 con 5V y conectar DATA directo al GPIO.

## Reto corto

- Agrega un promedio simple cada 5 lecturas.
- Muestra un mensaje de alerta si la temperatura supera un umbral.
