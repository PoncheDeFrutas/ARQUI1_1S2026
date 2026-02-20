import time

from rpi_lcd import LCD


def main() -> None:
    lcd = LCD(0x27, 1, 16, 2, True)
    labels = [
        ("Izquierda", None),
        ("Centro", "center"),
        ("Derecha", "right"),
    ]

    try:
        for label, align in labels:
            lcd.clear()
            if align is None:
                lcd.text(label, 1)
            else:
                lcd.text(label, 1, align)
            lcd.text("Alineacion", 2, "center")
            time.sleep(2)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        lcd.clear()


if __name__ == "__main__":
    main()
