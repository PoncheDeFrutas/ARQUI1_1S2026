import time
import board
import adafruit_dht
import RPi.GPIO as GPIO
from globals import shared

class Sensors:

    def __init__(self):
        self.dht = adafruit_dht.DHT11(board.D20)
        self.last_read_time_dht = 0
        self.read_interval_dht = 5
        # Configuración de otros sensores (p.ej. MQ-135) aquí

    def read_sensors(self):
        tiempo_actual = time.time()

        if tiempo_actual - self.last_read_time_dht >= self.read_interval_dht:
            self.read_dht11()
            self.last_read_time_dht = tiempo_actual

        # Lectura de otros sensores aquí (p.ej. MQ-135)


    def read_dht11(self):
        try:
            temperature_c = self.dht.temperature
            humidity = self.dht.humidity
            if temperature_c is not None and humidity is not None:
                shared.temperature = temperature_c
                shared.humidity = humidity
            else:
                shared.local_error_message = "Error al leer DHT11"
        except RuntimeError as e:
            shared.local_error_message = f"RuntimeError: {e}"

    def print_sensors(self):
        print(f"Temperatura: {shared.temperature} °C")
        print(f"Humedad: {shared.humidity} %")
        if shared.local_error_message:
            print(f"Error: {shared.local_error_message}")

    def cleanup(self):
        self.dht.exit()
        GPIO.cleanup()
