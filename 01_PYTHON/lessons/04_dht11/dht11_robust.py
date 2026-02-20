import time

import adafruit_dht
import board


def main() -> None:
    sensor = adafruit_dht.DHT11(board.D20)
    max_errors = 8
    error_count = 0
    last_temperature = None
    last_humidity = None

    try:
        while True:
            try:
                temperature_c = sensor.temperature
                humidity = sensor.humidity

                if temperature_c is None or humidity is None:
                    raise RuntimeError("Lectura nula")

                last_temperature = temperature_c
                last_humidity = humidity
                error_count = 0
                print(f"Temp: {temperature_c:.1f} C | Humedad: {humidity:.1f}%")
            except RuntimeError:
                error_count += 1
                if last_temperature is not None and last_humidity is not None:
                    print(
                        "Lectura fallida. Usando último valor válido: "
                        f"{last_temperature:.1f} C | {last_humidity:.1f}%"
                    )
                else:
                    print("Lectura fallida. Reintentando...")

                if error_count >= max_errors:
                    print("Demasiados errores seguidos. Reiniciando sensor...")
                    sensor.exit()
                    time.sleep(1)
                    sensor = adafruit_dht.DHT11(board.D20)
                    error_count = 0

            time.sleep(2)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        sensor.exit()


if __name__ == "__main__":
    main()
