"""
=========================================================
* Lección 03: Heartbeat LED en hilo de fondo
* Descripción: Un hilo aparte parpadea el LED en GPIO18
* para indicar que el sistema está vivo, mientras el hilo
* principal queda libre para otras tareas.
=========================================================
"""

import threading
import time
import RPi.GPIO as GPIO

LED_PIN = 18
PERIOD = 0.5  # segundos

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(LED_PIN, GPIO.OUT, initial=GPIO.LOW)

stop_event = threading.Event()


def heartbeat():
    state = False
    while not stop_event.is_set():
        state = not state
        GPIO.output(LED_PIN, state)
        time.sleep(PERIOD)


thread = threading.Thread(target=heartbeat, daemon=True)
thread.start()

try:
    print("Heartbeat corriendo en segundo plano. Ctrl+C para salir.")
    while True:
        time.sleep(1)  # el hilo principal queda disponible
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    stop_event.set()
    thread.join()
    GPIO.cleanup()
