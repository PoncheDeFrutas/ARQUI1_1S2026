"""Conexion basica a un broker MQTT.

Este script solo prueba la conexion y desconexion.
"""

import random
import time

from paho.mqtt import client as mqtt_client

BROKER = "broker.emqx.io"
PORT = 1883
CLIENT_ID = f"python-basic-{random.randint(0, 1000)}"
USERNAME = None  # Ej: "user"
PASSWORD = None  # Ej: "pass"


connected = False


def on_connect(client: mqtt_client.Client, userdata: object, flags: dict, rc: int) -> None:
    global connected
    if rc == 0:
        print("Conectado al broker")
        connected = True
    else:
        print(f"Fallo de conexion, codigo: {rc}")


def main() -> None:
    client = mqtt_client.Client(client_id=CLIENT_ID)

    client.on_connect = on_connect
    client.connect(BROKER, PORT, keepalive=60)
    client.loop_start()

    # Espera breve para confirmar conexion
    timeout = time.time() + 5
    while not connected and time.time() < timeout:
        time.sleep(0.1)

    client.disconnect()
    client.loop_stop()
    print("Desconectado")


if __name__ == "__main__":
    main()
