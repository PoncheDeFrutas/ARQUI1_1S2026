# Lección 05: Pantalla LCD I2C (Raspberry Pi)

Esta lección muestra cómo usar una pantalla LCD I2C con la librería `rpi_lcd` y cómo aprovechar sus funciones principales: escribir texto, alineación y limpieza de pantalla.

## Objetivos

- Mostrar texto en una LCD I2C desde Raspberry Pi.
- Usar alineación izquierda/centro/derecha.
- Limpiar y actualizar la pantalla de forma controlada.

## Requisitos

- Raspberry Pi con Raspberry Pi OS.
- Python 3.
- Pantalla LCD I2C (16x2 o 20x4) con backpack I2C.
- I2C habilitado y `python-smbus` instalado.

## Conexión (modo BCM)

LCD I2C (backpack típico):

- VCC -> 5V o 3.3V (según el módulo)
- GND -> GND
- SDA -> GPIO2 (pin físico 3)
- SCL -> GPIO3 (pin físico 5)

> Verifica que tu módulo sea compatible con 3.3V en las líneas I2C.

## Dirección I2C y dimensiones

La mayoría de LCD con backpack I2C usan direcciones **0x27** o **0x3F**. La dirección depende del chip expansor (PCF8574/PCF8574A) y de cómo están configurados sus pines A0–A2. Por eso, dos pantallas iguales pueden responder a direcciones distintas.

En esta lección usaremos:

```python
lcd = LCD(0x27, 1, 16, 2, True)
```

Significado de los parámetros:

- `0x27`: dirección I2C del backpack.
- `1`: número de bus I2C (en Raspberry Pi normalmente es `1`).
- `16`: número de columnas de la LCD.
- `2`: número de filas de la LCD.
- `True`: activa el backlight al iniciar.

Si tu LCD no responde, cambia la dirección a `0x3F` o escanéala con `i2cdetect -y 1`.

## Instalación de librería

```bash
python3 -m pip install rpi-lcd
```

## Archivos de la lección

- `lcd_basic.py`: escritura básica en dos líneas.
- `lcd_alignment.py`: ejemplo de alineación izquierda/centro/derecha.
- `lcd_multiline.py`: texto largo con manejo de salto de línea automático.

## Cómo ejecutar

Desde esta carpeta:

```bash
python3 lcd_basic.py
python3 lcd_alignment.py
python3 lcd_multiline.py
```

Detén con `Ctrl+C` si el ejemplo está en bucle.

## Qué puedes modificar

- Dirección I2C: prueba `0x27` o `0x3F` según tu módulo.
- Dimensiones: ajusta columnas/filas si tu LCD es 20x4.
- Mensajes: cambia el texto y tiempos de actualización.
- Alineación: usa `left` (por defecto), `center` o `right`.

## Errores comunes

- I2C deshabilitado en la Raspberry Pi.
- Dirección I2C distinta a la esperada.
- Cableado SDA/SCL invertido.

## Reto corto

- Muestra un contador que aumente cada segundo.
- Alterna entre dos mensajes con `lcd.clear()`.
