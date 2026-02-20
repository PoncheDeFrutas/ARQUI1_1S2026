"""
=========================================================
* Lección 03: Sensor periódico + botón con callback
* Descripción: Un hilo lee un "sensor" cada 2 s (aquí
* simulado) mientras el botón en GPIO17 usa eventos para
* conmutar el LED en GPIO18 sin bloquear el hilo principal.
=========================================================
"""

import threading
import time
import random
import RPi.GPIO as GPIO

BUTTON_PIN = 17
LED_PIN = 18
SENSOR_PERIOD = 2.0  # segundos

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(LED_PIN, GPIO.OUT, initial=GPIO.LOW)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

stop_event = threading.Event()
led_state = False


def read_sensor():
    """Simula lectura de sensor (ej. temperatura)."""
    return round(20 + random.random() * 5, 2)


def sensor_loop():
    while not stop_event.is_set():
        value = read_sensor()
        print(f"[Sensor] valor = {value} °C")
        time.sleep(SENSOR_PERIOD)


def on_button(channel):
    global led_state
    led_state = not led_state
    GPIO.output(LED_PIN, led_state)
    print(f"[Botón] LED {'ON' if led_state else 'OFF'}")


GPIO.add_event_detect(BUTTON_PIN, GPIO.FALLING, callback=on_button, bouncetime=120)

thread = threading.Thread(target=sensor_loop, daemon=True)
thread.start()

try:
    print("Sensor en hilo + botón por eventos. Ctrl+C para salir.")
    while True:
        time.sleep(0.5)
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    stop_event.set()
    thread.join()
    GPIO.cleanup()
