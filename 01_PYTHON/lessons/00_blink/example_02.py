"""
=========================================================
* Lección 00: Secuencia de LEDs
* Descripción: Este programa enciende y apaga una serie de LEDs conectados
* a varios pines GPIO de una Raspberry Pi, creando un efecto de "barrido".
* Cada LED se enciende por 0.2 segundos y se apaga antes de pasar al siguiente,
* repitiendo el ciclo indefinidamente. Incluye manejo de excepciones y limpieza
* de recursos al salir con Ctrl+C.
=========================================================
"""

import RPi.GPIO as GPIO
import time

# Configuración de Modo de Pines
GPIO.setmode(GPIO.BCM)

# Lista de pines para los LEDs (ajusta según tu conexión)
LED_PINS = [18, 23, 24, 25]

# Desactivar advertencias
GPIO.setwarnings(False)

# Configuración de Pines
for pin in LED_PINS:
    GPIO.setup(pin, GPIO.OUT)
    GPIO.output(pin, GPIO.LOW)

try:
    while True:
        try:
            print("Secuencia de LEDs...")
            # Barrido hacia adelante
            for pin in LED_PINS:
                GPIO.output(pin, GPIO.HIGH)
                time.sleep(0.2)
                GPIO.output(pin, GPIO.LOW)
            # Barrido hacia atrás
            for pin in reversed(LED_PINS):
                GPIO.output(pin, GPIO.HIGH)
                time.sleep(0.2)
                GPIO.output(pin, GPIO.LOW)
        except RuntimeError as e:
            print(f"RuntimeError: {e.args[0]}")
        except Exception as e:
            print(f"An error occurred: {e}")
except KeyboardInterrupt:
    print("Exiting program...")
finally:
    GPIO.cleanup()
