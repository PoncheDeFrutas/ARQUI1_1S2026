import time

import adafruit_dht
import board


def main() -> None:
    sensor = adafruit_dht.DHT11(board.D20)
    try:
        while True:
            try:
                temperature_c = sensor.temperature
                humidity = sensor.humidity
                if temperature_c is None or humidity is None:
                    print("Lectura inválida. Reintentando...")
                else:
                    print(f"Temp: {temperature_c:.1f} C | Humedad: {humidity:.1f}%")
            except RuntimeError as exc:
                # Errores típicos del DHT11 (checksum/timeouts)
                print(f"Error de lectura: {exc}")

            time.sleep(2)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        sensor.exit()


if __name__ == "__main__":
    main()
