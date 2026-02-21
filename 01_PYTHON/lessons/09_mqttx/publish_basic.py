"""Publicar un mensaje simple en MQTT.

Se conecta, publica un mensaje y se desconecta.
"""

import random
import time

from paho.mqtt import client as mqtt_client

BROKER = "broker.emqx.io"
PORT = 1883
TOPIC = "ARQUI1B_2026/test"
CLIENT_ID = f"python-pub-{random.randint(0, 1000)}"
USERNAME = None
PASSWORD = None


def on_connect(client: mqtt_client.Client, userdata: object, flags: dict, rc: int) -> None:
    if rc == 0:
        print("Conectado al broker")
    else:
        print(f"Fallo de conexion, codigo: {rc}")


def main() -> None:
    client = mqtt_client.Client(client_id=CLIENT_ID)

    client.on_connect = on_connect
    client.connect(BROKER, PORT, keepalive=60)
    client.loop_start()

    message = f"Hola MQTTX {time.strftime('%H:%M:%S')}"
    result = client.publish(TOPIC, message, qos=0)
    status = result[0]
    if status == 0:
        print(f"Mensaje enviado a {TOPIC}: {message}")
    else:
        print(f"Fallo al enviar mensaje a {TOPIC}")

    time.sleep(1)
    client.disconnect()
    client.loop_stop()


if __name__ == "__main__":
    main()
