import time
import random
import RPi.GPIO as GPIO
import paho.mqtt.client as mqtt_client

# GPIO setup
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

LED_PIN = 18
GPIO.setup(LED_PIN, GPIO.OUT, initial=GPIO.LOW)

# MQTT setup
BROKER = "broker.emqx.io"
PORT = 1883
CLIENT_ID = f"python-basic-{random.randint(0, 1000)}"
TOPIC = "ARQUI1/TEST/COMANDOS"

def connect_mqtt() -> mqtt_client.Client:

    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Conectado al broker MQTT")
            print(f"Suscrito a {TOPIC}")
        else:
            print(f"Fallo de conexion, codigo: {rc}")


    client = mqtt_client.Client(client_id=CLIENT_ID)
    client.on_connect = on_connect
    client.connect(BROKER, PORT)
    return client

def subscribe(client: mqtt_client.Client) -> None:

    def on_message(client, userdata, msg):
        print(f"Mensaje recibido: {msg.topic} -> {msg.payload.decode()}")
        if msg.payload.decode().lower() == "on":
            GPIO.output(LED_PIN, GPIO.HIGH)
            print("LED encendido")
        else:
            GPIO.output(LED_PIN, GPIO.LOW)
            print("LED apagado")

    client.subscribe(TOPIC)
    client.on_message = on_message

def run() -> None:
    client = connect_mqtt()
    subscribe(client)
    client.loop_start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        GPIO.cleanup()
        client.disconnect()
        client.loop_stop()

if __name__ == "__main__":
    run()
