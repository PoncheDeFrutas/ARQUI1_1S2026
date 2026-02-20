"""
=========================================================
* Lección 03: Temporizador rearmable con threading.Timer
* Descripción: Ejecuta una tarea cada 3 segundos sin
* bloquear el hilo principal. Rearma el timer al final
* de cada ejecución.
=========================================================
"""

import threading
import time
import RPi.GPIO as GPIO

LED_PIN = 18
PERIOD = 3.0  # segundos

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(LED_PIN, GPIO.OUT, initial=GPIO.LOW)

stop_event = threading.Event()
led_state = False


def task():
    global led_state, timer
    if stop_event.is_set():
        return
    led_state = not led_state
    GPIO.output(LED_PIN, led_state)
    print(f"[Timer] LED {'ON' if led_state else 'OFF'}")
    # Rearma el timer
    timer = threading.Timer(PERIOD, task)
    timer.daemon = True
    timer.start()


# Primer arranque
timer = threading.Timer(PERIOD, task)
timer.daemon = True
timer.start()

try:
    print("Timer rearmable cada 3 s. Ctrl+C para salir.")
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    stop_event.set()
    timer.cancel()
    GPIO.cleanup()
