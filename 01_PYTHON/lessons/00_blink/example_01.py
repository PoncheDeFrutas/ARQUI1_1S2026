"""
=========================================================
* Lección 00: Parpadeo de un LED
* Descripción: Este programa hace parpadear un LED conectado al pin GPIO 18 de una Raspberry Pi.
* El LED se encenderá durante 1 segundo y luego se apagará durante 1 segundo,
* repitiendo este ciclo indefinidamente.
* El programa también maneja excepciones para garantizar que el programa no se bloquee en caso
* de errores y permite una salida limpia al presionar Ctrl+C.
=========================================================
"""

import RPi.GPIO as GPIO
import time

# Configuración de Modo de Pines
GPIO.setmode(GPIO.BCM)

# Configuración de Pines
GPIO.setup(18, GPIO.OUT)

# Desactivar advertencias
GPIO.setwarnings(False)

try:
    while True:
        try:
            print("Blinking LED...")
            GPIO.output(18, GPIO.HIGH)  # Enciende el LED
            time.sleep(1)               # Espera 1 segundo
            GPIO.output(18, GPIO.LOW)   # Apaga el LED
            time.sleep(1)               # Espera 1 segundo
        except RuntimeError as e:               # Maneja errores específicos de tiempo de ejecución
            print(f"RuntimeError: {e.args[0]}")
        except Exception as e:                  # Maneja cualquier otro tipo de excepción
            print(f"An error occurred: {e}")
except KeyboardInterrupt:                       # Permite salir del programa con Ctrl+C
        print("Exiting program...")
finally:                                        # Asegura que los recursos se limpien correctamente
        GPIO.cleanup()
