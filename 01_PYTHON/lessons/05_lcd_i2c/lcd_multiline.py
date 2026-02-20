import time

from rpi_lcd import LCD


def main() -> None:
    lcd = LCD(0x27, 1, 16, 2, True)
    message = "Texto largo para probar\nlineas multiples"

    try:
        lcd.text(message, 1)
        time.sleep(5)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        lcd.clear()


if __name__ == "__main__":
    main()
