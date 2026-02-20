import time

import adafruit_ssd1306
import board
import busio
from PIL import Image, ImageDraw, ImageFont


def draw_screen(oled, title: str, lines: list[str]) -> None:
    image = Image.new("1", (128, 64))
    draw = ImageDraw.Draw(image)
    font = ImageFont.load_default()

    draw.text((0, 0), title, font=font, fill=255)
    y = 16
    for line in lines:
        draw.text((0, y), line, font=font, fill=255)
        y += 12

    oled.image(image)
    oled.show()


def main() -> None:
    i2c = busio.I2C(board.SCL, board.SDA)
    oled = adafruit_ssd1306.SSD1306_I2C(128, 64, i2c, addr=0x3C)

    screens = [
        ("Pantalla 1", ["Estado: OK", "Temp: 24C", "Hum: 45%"]),
        ("Pantalla 2", ["Modo: Auto", "PWM: 60%", "LED: ON"]),
        ("Pantalla 3", ["IP: 192.168.1.5", "RSSI: -60", "Uptime: 2h"]),
    ]

    try:
        index = 0
        while True:
            title, lines = screens[index]
            draw_screen(oled, title, lines)
            index = (index + 1) % len(screens)
            time.sleep(2)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        oled.fill(0)
        oled.show()


if __name__ == "__main__":
    main()
