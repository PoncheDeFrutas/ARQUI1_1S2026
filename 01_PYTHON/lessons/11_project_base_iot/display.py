import time
from rpi_lcd import LCD
from globals import shared


class Display:
    def __init__(self):
        self.lcd = LCD(0x27, 1, 16, 2, True)
        self.enable = True
        self.last_update_time = 0
        self.threshold_data = 2
        self.threshold_error = 5
        self.lcd.clear()
        self.lcd.backlight(self.enable)
        self.last_screen = 0

    def display_data(self):
        self.lcd.clear()
        match self.last_screen:
            case 0:
                self.lcd.text(f"Temp: {shared.temperature:.1f}C", 1)
                self.last_screen += 1
            case 1:
                self.lcd.text(f"Hum: {shared.humidity:.1f}%", 1)
                self.last_screen += 1
            case 2:
                self.lcd.text(f"HOLA",1)
                self.last_screen = 0

    def display_error(self):
        self.lcd.clear()
        self.lcd.text(shared.local_error_message, 1)
        self.enable = False

    def update(self):
        tiempo_actual = time.time()

        if not self.enable:
            if tiempo_actual - self.last_update_time >= self.threshold_error:
                self.enable = True
            else:
                return
        else:
            if not (tiempo_actual - self.last_update_time >= self.threshold_data):
                return

        if shared.local_error_message:
            self.display_error()
            shared.local_error_message = ""
        else:
            self.display_data()

        self.last_update_time = tiempo_actual

    def clear(self):
        self.lcd.clear()






