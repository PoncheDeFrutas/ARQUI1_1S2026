# Leccion 09: MQTT (MQTTX)

Esta leccion incluye ejemplos basicos para conectarse a un broker MQTT, publicar mensajes, suscribirse a topicos y manejar reconexiones. Son ejemplos simples y bien comentados para usar con MQTTX como cliente de pruebas.

## Requisitos

- Python 3.
- Libreria `paho-mqtt`.
- Un broker MQTT (local o remoto).
- MQTTX instalado (opcional, para pruebas graficas).

Instalacion:

```bash
python3 -m pip install paho-mqtt
```

## Parametros comunes

En todos los ejemplos hay variables al inicio del archivo:

- `BROKER`: direccion del broker.
- `PORT`: puerto (1883 sin TLS).
- `TOPIC`: topico base.
- `CLIENT_ID`: id del cliente.
- `USERNAME` y `PASSWORD` si tu broker requiere autenticacion.

## Flujo basico del cliente (paho-mqtt)

- `connect(...)`: abre la conexion TCP con el broker y prepara el cliente MQTT.
- `loop_start()`: inicia un hilo que procesa la red. Sin esto no se reciben mensajes ni se mantienen los keepalive.
- `loop_stop()`: detiene el hilo de red.
- `disconnect()`: cierra la conexion de forma ordenada.

Alternativas al `loop_start()`:

- `loop_forever()`: bloquea y procesa la red en el hilo principal.
- `loop(timeout=...)`: se llama dentro de tu propio bucle.

## Callbacks principales

- `on_connect(client, userdata, flags, rc)`: se ejecuta cuando el cliente logra conectar. Si `rc == 0`, la conexion fue exitosa. Aqui normalmente te suscribes a topicos.
- `on_message(client, userdata, msg)`: se ejecuta cada vez que llega un mensaje a un topico suscrito.
- `on_disconnect(client, userdata, rc)`: se ejecuta al desconectarse. Si `rc != 0`, fue una desconexion inesperada.

## Ejemplo de flujo tipico

1. Crear cliente.
2. Configurar callbacks.
3. `connect(...)`
4. `loop_start()` o `loop_forever()`
5. Publicar / suscribirse.
6. `disconnect()` y `loop_stop()`.

## Archivos de la leccion

- `client.py`: conexion basica al broker.
- `publish_basic.py`: publicar un mensaje simple.
- `subscribe_basic.py`: suscribirse y recibir mensajes.
- `pub_sub_reconnect.py`: publicar y suscribirse con reconexion.

## Como probar con MQTTX

1. Abre MQTTX y crea una conexion con el mismo broker y puerto.
2. Suscribete al topico usado en los ejemplos.
3. Ejecuta los scripts y observa los mensajes.

## Consejos basicos

- Usa topicos claros, por ejemplo `clase/demo`.
- Si no ves mensajes, verifica broker, topico y puerto.
- En redes locales, puedes usar un broker en tu misma Raspberry Pi.
