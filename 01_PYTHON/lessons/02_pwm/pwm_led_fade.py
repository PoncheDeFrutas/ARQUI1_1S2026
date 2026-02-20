"""
=========================================================
* Lección 02: PWM en LED (fade in/out)
* Descripción: Usa PWM a 1000 Hz en GPIO18 para variar
* el brillo de un LED en rampas suaves.
=========================================================
"""

import RPi.GPIO as GPIO
import time

LED_PIN = 18
FREQ_HZ = 1000  # frecuencia alta para evitar parpadeo visible
STEP = 5        # incremento de duty en %
DELAY = 0.05    # tiempo entre pasos

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(LED_PIN, GPIO.OUT)

pwm = GPIO.PWM(LED_PIN, FREQ_HZ)
pwm.start(0)  # duty 0%

try:
    while True:
        for duty in range(0, 101, STEP):
            pwm.ChangeDutyCycle(duty)
            time.sleep(DELAY)
        for duty in range(100, -1, -STEP):
            pwm.ChangeDutyCycle(duty)
            time.sleep(DELAY)
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    pwm.stop()
    GPIO.cleanup()
