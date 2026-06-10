import time
import sensors
import display

class iot_program:

    def __init__(self):
        self.running = True
        self.intervals = {
            "principal": 0.2,
            "MQTT": 1.0,
        }

        self.sensors = sensors.Sensors()
        self.display = display.Display()

        #mensaje de inicializacion en el display

    def run_task(self):
        self.sensors.read_sensors()
        self.sensors.print_sensors()
        #mqtt
        #mongodb
        self.display.update()

    # hilo que se ejecute cada 1 segundo
    def mqtt_task(self):
        # globals.shared
        pass

    # hilo que se ejecute cada 0.5 segundos
    def mongodb_task(self):
        # globals.shared
        pass

    def main_loop(self):
        try:
            while self.running:
                self.run_task()
                time.sleep(self.intervals["principal"])
        except KeyboardInterrupt:
            print("Saliendo...")
        finally:
            self.running = False
            self.sensors.cleanup()
            self.display.clear()
            print("Programa terminado.")


if __name__ == "__main__":
    program = iot_program()
    program.main_loop()
