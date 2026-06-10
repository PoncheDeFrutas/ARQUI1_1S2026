"""Suscribirse a un topico y mostrar mensajes.

Ejecuta este script y publica desde MQTTX al mismo topico.
"""

import random
import time

from paho.mqtt import client as mqtt_client

BROKER = "broker.emqx.io"
PORT = 1883
TOPIC = "ARQUI1B_2026/test"
CLIENT_ID = f"python-sub-{random.randint(0, 1000)}"
USERNAME = None
PASSWORD = None


def on_connect(client: mqtt_client.Client, userdata: object, flags: dict, rc: int) -> None:
    if rc == 0:
        print("Conectado al broker")
        client.subscribe(TOPIC)
        print(f"Suscrito a {TOPIC}")
    else:
        print(f"Fallo de conexion, codigo: {rc}")


def on_message(client: mqtt_client.Client, userdata: object, msg: mqtt_client.MQTTMessage) -> None:
    print(f"Mensaje recibido: {msg.topic} -> {msg.payload.decode()}")


def main() -> None:
    client = mqtt_client.Client(client_id=CLIENT_ID)

    client.on_connect = on_connect
    client.on_message = on_message

    client.connect(BROKER, PORT, keepalive=60)
    client.loop_start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("Saliendo...")
    finally:
        client.disconnect()
        client.loop_stop()


if __name__ == "__main__":
    main()
