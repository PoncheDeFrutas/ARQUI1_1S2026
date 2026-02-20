import math
import time

import adafruit_ssd1306
import board
import busio
from PIL import Image, ImageDraw, ImageFont


def main() -> None:
    i2c = busio.I2C(board.SCL, board.SDA)
    oled = adafruit_ssd1306.SSD1306_I2C(128, 64, i2c, addr=0x3C)

    width = 128
    height = 64
    data = [height // 2] * width

    try:
        t = 0.0
        while True:
            image = Image.new("1", (width, height))
            draw = ImageDraw.Draw(image)
            font = ImageFont.load_default()

            # Genera un valor tipo onda para simular datos
            value = (math.sin(t) + 1) / 2  # 0..1
            y = int((1 - value) * (height - 1))
            data.pop(0)
            data.append(y)

            # Ejes simples
            draw.line((0, height - 1, width - 1, height - 1), fill=255)
            draw.line((0, 0, 0, height - 1), fill=255)

            # Grafica
            for x in range(1, width):
                draw.line((x - 1, data[x - 1], x, data[x]), fill=255)

            draw.text((2, 2), "Grafica", font=font, fill=255)

            oled.image(image)
            oled.show()

            t += 0.2
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        oled.fill(0)
        oled.show()


if __name__ == "__main__":
    main()
