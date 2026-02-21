import time
from typing import Literal

import RPi.GPIO as GPIO

S0_PIN = 17
S1_PIN = 27
S2_PIN = 22
S3_PIN = 23
OUT_PIN = 24

MEASURE_TIME_S = 0.2


LOW: Literal[0] = 0
HIGH: Literal[1] = 1

FILTERS: dict[str, tuple[Literal[0, 1], Literal[0, 1]]] = {
    "red": (LOW, LOW),
    "blue": (LOW, HIGH),
    "clear": (HIGH, LOW),
    "green": (HIGH, HIGH),
}

SCALE_20: tuple[Literal[0, 1], Literal[0, 1]] = (HIGH, LOW)


def set_filter(name: str) -> None:
    s2, s3 = FILTERS[name]
    GPIO.output(S2_PIN, s2)
    GPIO.output(S3_PIN, s3)


def count_pulses(duration_s: float) -> int:
    count = 0
    end_time = time.monotonic() + duration_s

    while time.monotonic() < end_time:
        remaining_ms = int((end_time - time.monotonic()) * 1000)
        if remaining_ms <= 0:
            break
        if GPIO.wait_for_edge(OUT_PIN, GPIO.RISING, timeout=remaining_ms):
            count += 1

    return count


def read_frequency() -> float:
    pulses = count_pulses(MEASURE_TIME_S)
    return pulses / MEASURE_TIME_S


def main() -> None:
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)

    GPIO.setup(S0_PIN, GPIO.OUT)
    GPIO.setup(S1_PIN, GPIO.OUT)
    GPIO.setup(S2_PIN, GPIO.OUT)
    GPIO.setup(S3_PIN, GPIO.OUT)
    GPIO.setup(OUT_PIN, GPIO.IN)

    # Escalado al 20% (mas estable)
    GPIO.output(S0_PIN, SCALE_20[0])
    GPIO.output(S1_PIN, SCALE_20[1])

    try:
        while True:
            freqs = {}
            for name in ("red", "green", "blue"):
                set_filter(name)
                time.sleep(0.05)  # tiempo de asentamiento
                freqs[name] = read_frequency()

            total = freqs["red"] + freqs["green"] + freqs["blue"]
            if total > 0:
                norm_r = freqs["red"] / total
                norm_g = freqs["green"] / total
                norm_b = freqs["blue"] / total
                print(
                    f"R: {freqs['red']:.1f} Hz | "
                    f"G: {freqs['green']:.1f} Hz | "
                    f"B: {freqs['blue']:.1f} Hz || "
                    f"Norm: R={norm_r:.2f} G={norm_g:.2f} B={norm_b:.2f}"
                )
            else:
                print("Lectura invalida")

            time.sleep(0.3)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        GPIO.cleanup()


if __name__ == "__main__":
    main()
