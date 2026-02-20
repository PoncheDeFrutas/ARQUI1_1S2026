# Leccion 06: Pantalla OLED I2C (SSD1306)

Esta leccion muestra como usar una pantalla OLED I2C 128x64 con el controlador SSD1306 desde Raspberry Pi usando la libreria `adafruit-circuitpython-ssd1306`.

## Objetivos

- Inicializar el bus I2C y la pantalla OLED.
- Mostrar texto y dibujar pixeles.
- Actualizar la pantalla de forma limpia y controlada.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Pantalla OLED I2C 128x64 (0.96").
- I2C habilitado.

> Si tu modulo indica otro controlador, confirma el modelo exacto. Esta leccion asume SSD1306.

## Habilitar I2C

Si I2C no esta habilitado, usa `raspi-config` y activa la opcion I2C en Interface Options. Luego reinicia.

## Conexion (modo BCM)

OLED I2C:

- VCC -> 3.3V o 5V (segun el modulo)
- GND -> GND
- SDA -> GPIO2 (pin fisico 3)
- SCL -> GPIO3 (pin fisico 5)

## Direccion I2C

En tu bus se detecto `0x3C`, asi que usaremos esa direccion. Si no responde, escanea el bus con:

```bash
sudo i2cdetect -y 1
```

## Instalacion de librerias

1. Instala Blinka (si aun no esta instalado):

```bash
python3 -m pip install adafruit-blinka
```

2. Instala el driver de la pantalla:

```bash
python3 -m pip install adafruit-circuitpython-ssd1306
```

3. Instala Pillow (para dibujar texto e imagenes):

```bash
python3 -m pip install pillow
```

## Archivos de la leccion

- `oled_basic.py`: texto basico en pantalla.
- `oled_counter.py`: contador que se actualiza cada segundo.
- `oled_pixels.py`: dibujo simple con pixeles.
- `oled_graph.py`: grafica en tiempo real con datos simulados.
- `oled_menu.py`: navegacion entre pantallas (cambio automatico).
- `oled_animation.py`: animacion simple (rebote).

## Como ejecutar

Desde esta carpeta:

```bash
python3 oled_basic.py
python3 oled_counter.py
python3 oled_pixels.py
python3 oled_graph.py
python3 oled_menu.py
python3 oled_animation.py
```

Deten con `Ctrl+C` si el ejemplo esta en bucle.

## Que puedes modificar

- Direccion I2C: cambia `addr=0x3C` al valor detectado por `i2cdetect`.
- Resolucion: ajusta `128, 64` si tu OLED es 128x32.
- Mensajes y tiempos de actualizacion.

## Errores comunes

- I2C deshabilitado en la Raspberry Pi.
- Direccion I2C distinta a la esperada.
- Cableado SDA/SCL invertido.
- Error `font5x8.bin`: usa los ejemplos con Pillow o instala la fuente si usas `oled.text(...)`.
