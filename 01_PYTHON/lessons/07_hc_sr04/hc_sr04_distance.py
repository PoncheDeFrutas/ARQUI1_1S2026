import statistics
import time

import RPi.GPIO as GPIO

TRIG_PIN = 23
ECHO_PIN = 24
MEASURE_DELAY = 0.2
SPEED_OF_SOUND_CM_S = 34300  # cm/s
TIMEOUT_S = 0.02  # 20 ms ~ 3.4 m
SAMPLES = 5


def read_distance_cm() -> float | None:
    # Pulso TRIG de 10 us
    GPIO.output(TRIG_PIN, GPIO.LOW)
    time.sleep(0.0002)
    GPIO.output(TRIG_PIN, GPIO.HIGH)
    time.sleep(0.00001)
    GPIO.output(TRIG_PIN, GPIO.LOW)

    start_time = time.time()

    # Espera a que ECHO suba
    while GPIO.input(ECHO_PIN) == GPIO.LOW:
        if time.time() - start_time > TIMEOUT_S:
            return None

    pulse_start = time.time()

    # Espera a que ECHO baje
    while GPIO.input(ECHO_PIN) == GPIO.HIGH:
        if time.time() - pulse_start > TIMEOUT_S:
            return None

    pulse_end = time.time()
    pulse_duration = pulse_end - pulse_start

    distance_cm = (pulse_duration * SPEED_OF_SOUND_CM_S) / 2
    return distance_cm


def main() -> None:
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)

    GPIO.setup(TRIG_PIN, GPIO.OUT)
    GPIO.setup(ECHO_PIN, GPIO.IN)

    try:
        while True:
            samples: list[float] = []
            for _ in range(SAMPLES):
                value = read_distance_cm()
                if value is not None:
                    samples.append(value)
                time.sleep(0.05)

            if samples:
                distance = statistics.median(samples)
                print(f"Distancia: {distance:.1f} cm")
            else:
                print("Lectura invalida")

            time.sleep(MEASURE_DELAY)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        GPIO.cleanup()


if __name__ == "__main__":
    main()
