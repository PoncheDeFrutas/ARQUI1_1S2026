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

        draw.text((0, 0), "OLED I2C", font=font, fill=255)
        draw.text((0, 16), "128x64", font=font, fill=255)
        draw.text((0, 32), "SSD1306", font=font, fill=255)

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
