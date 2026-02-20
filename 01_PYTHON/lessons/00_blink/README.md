# Lección 00: Parpadeo y secuencia de LEDs (Raspberry Pi)

Esta lección introduce lo básico para controlar LEDs con GPIO en una Raspberry Pi usando Python y la librería `RPi.GPIO`.

## Objetivo

- Encender y apagar un LED (parpadeo).
- Encender una serie de LEDs en secuencia (barrido).
- Entender la estructura básica de un programa de control por GPIO.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Librería `RPi.GPIO` instalada.
- LEDs, resistencias (220Ω–330Ω) y cables.

## Archivos de la lección

- `example_01.py`: parpadeo de un LED en un pin GPIO.
- `example_02.py`: secuencia de varios LEDs (ida y vuelta).

## Conexión básica

1. Conecta el ánodo (pata larga) del LED a un pin GPIO.
2. Conecta el cátodo (pata corta) a GND con una resistencia.

En `example_02.py`, los pines usados por defecto son: `18, 23, 24, 25`.

## ¿Cómo se empieza un programa de GPIO?

Un programa típico tiene estas partes:

1. **Importaciones**
   - `RPi.GPIO` para controlar los pines.
   - `time` para usar pausas (`sleep`).

2. **Configuración**
   - `GPIO.setmode(GPIO.BCM)` define el modo de numeración.
   - `GPIO.setup(pin, GPIO.OUT)` configura el pin como salida.
   - `GPIO.setwarnings(False)` evita mensajes si el pin ya está en uso.

3. **Lógica principal**
   - Encender (`GPIO.HIGH`) y apagar (`GPIO.LOW`) según el tiempo.

4. **Limpieza**
   - `GPIO.cleanup()` libera los pines al salir.

## ¿Por qué usamos un bucle infinito (`while True`)?

Porque queremos que el efecto (parpadeo o secuencia) se repita constantemente.
Sin el bucle, el programa encendería/apagaría una vez y terminaría.

## Estructura base (idea general)

```python
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.OUT)
GPIO.setwarnings(False)

try:
    while True:
        GPIO.output(18, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(18, GPIO.LOW)
        time.sleep(1)
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    GPIO.cleanup()
```

## ¿Cómo ejecutar?

Desde la terminal en la carpeta de la lección:

```bash
python3 example_01.py
```

Para la secuencia:

```bash
python3 example_02.py
```

## Puntos importantes

- Siempre usa resistencias para proteger el LED.
- Respeta el modo de numeración (BCM).
- Usa `try/except/finally` para salir limpio con `Ctrl+C`.
- Ajusta los pines en el código según tu conexión real.

## Qué puedes modificar

- Pines: cambia los GPIO en `GPIO.setup(...)` y en la lista del barrido.
- Velocidad: ajusta los `time.sleep(...)` para acelerar o ralentizar.
- Patrón: cambia el orden de la lista de pines o enciende varios a la vez.
- Modo de numeración: si cambias a `GPIO.BOARD`, actualiza todos los pines.

## Errores comunes

- Olvidar la resistencia del LED (riesgo de dañar el LED o el GPIO).
- Mezclar `BCM` con numeración física sin ajustar los pines.
- No ejecutar `GPIO.cleanup()` y dejar pines “ocupados”.
- Conectar el LED al revés (no enciende).

## Reto corto

- Haz que el parpadeo tenga un patrón 0.2s encendido y 0.8s apagado.
- En la secuencia, enciende dos LEDs a la vez (pares) y luego los impares.

## Siguiente paso

- Cambiar el tiempo de `sleep` para acelerar o ralentizar.
- Probar otras secuencias (por ejemplo, encender pares o todos a la vez).
