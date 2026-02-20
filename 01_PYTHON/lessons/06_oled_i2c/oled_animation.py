import time

import adafruit_ssd1306
import board
import busio
from PIL import Image, ImageDraw


def main() -> None:
    i2c = busio.I2C(board.SCL, board.SDA)
    oled = adafruit_ssd1306.SSD1306_I2C(128, 64, i2c, addr=0x3C)

    width = 128
    height = 64
    x = width // 2
    y = height // 2
    vx = 4
    vy = 2
    r = 4

    try:
        while True:
            image = Image.new("1", (width, height))
            draw = ImageDraw.Draw(image)

            draw.ellipse((x - r, y - r, x + r, y + r), outline=255, fill=255)

            oled.image(image)
            oled.show()

            x += vx
            y += vy

            min_x = r
            max_x = width - 1 - r
            min_y = r
            max_y = height - 1 - r

            if x <= min_x or x >= max_x:
                x = max(min_x, min(x, max_x))
                vx = -vx
            if y <= min_y or y >= max_y:
                y = max(min_y, min(y, max_y))
                vy = -vy

            time.sleep(0.03)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        oled.fill(0)
        oled.show()


if __name__ == "__main__":
    main()
