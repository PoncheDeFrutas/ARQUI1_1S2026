import time

from rpi_lcd import LCD


def main() -> None:
    lcd = LCD(0x27, 1, 16, 2, True)
    try:
        lcd.text("Hola", 1)
        lcd.text("LCD I2C", 2)
        time.sleep(5)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        lcd.clear()


if __name__ == "__main__":
    main()
