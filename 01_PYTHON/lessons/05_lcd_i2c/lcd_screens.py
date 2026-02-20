import time

from rpi_lcd import LCD


def main() -> None:
    lcd = LCD(0x27, 1, 16, 2, True)

    screens = [
        ("Pantalla 1", "Estado: OK"),
        ("Pantalla 2", "Temp: 24C"),
        ("Pantalla 3", "Hum: 45%"),
        ("Pantalla 4", "Modo: Auto"),
    ]

    try:
        index = 0
        while True:
            line1, line2 = screens[index]
            lcd.clear()
            lcd.text(line1, 1)
            lcd.text(line2, 2)
            index = (index + 1) % len(screens)
            time.sleep(2)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        lcd.clear()


if __name__ == "__main__":
    main()
