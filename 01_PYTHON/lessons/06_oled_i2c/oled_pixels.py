import time

import adafruit_ssd1306
import board
import busio
from PIL import Image, ImageDraw, ImageFont


def main() -> None:
    i2c = busio.I2C(board.SCL, board.SDA)
    oled = adafruit_ssd1306.SSD1306_I2C(128, 64, i2c, addr=0x3C)

    try:
        image = Image.new("1", (128, 64))
        draw = ImageDraw.Draw(image)
        font = ImageFont.load_default()

        # Borde superior e inferior
        for x in range(128):
            draw.point((x, 0), fill=255)
            draw.point((x, 63), fill=255)
        # Borde izquierdo y derecho
        for y in range(64):
            draw.point((0, y), fill=255)
            draw.point((127, y), fill=255)

        draw.text((40, 28), "Marco", font=font, fill=255)

        oled.image(image)
        oled.show()
        time.sleep(5)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        oled.fill(0)
        oled.show()


if __name__ == "__main__":
    main()
