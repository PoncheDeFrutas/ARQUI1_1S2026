# Lección 01: Botón, antirrebote y eventos (Raspberry Pi)

Esta lección cubre la primera entrada digital: leer un botón físico, evitar rebotes y reaccionar a eventos sin bloquear el programa.

## Objetivos

- Leer un botón con resistencias pull-up/pull-down.
- Implementar antirrebote (debounce) por software.
- Usar detección de eventos y callbacks en `RPi.GPIO`.
- Controlar un LED según pulsaciones cortas/largas.

## Requisitos

- Raspberry Pi con Raspberry Pi OS 64 bits.
- `RPi.GPIO` funcionando (ver checklist en `docs/prerrequisitos_hardware_software.md`).
- Hardware: 1 botón, 1 resistencia de 10 kΩ (pull-up o pull-down), 1 LED + 1 resistencia de 220–330 Ω, protoboard y jumpers.

## Pines (modo BCM)

- LED: GPIO 18 (pin físico 12).
- Botón: GPIO 17 (pin físico 11) con pull-up interno (`GPIO.PUD_UP`). El botón se conecta a GND.

## Archivos de la lección

- `example_01.py`: lectura con sondeo (polling) y antirrebote por tiempo.
- `example_02.py`: detección por eventos (`add_event_detect`) y callback.
- `example_03.py`: pulsación corta vs larga para alternar LED y apagar forzado.

## Esquema básico (pull-up interno)

```
3.3V   (no conectado al botón)
GPIO17 ---[pull-up interno]---+
                              |---- botón ---- GND
```

El LED se conecta como en la lección 00 (GPIO18 → resistencia 220–330 Ω → LED → GND).

## Cómo ejecutar

Desde esta carpeta:

```bash
python3 example_01.py   # polling con debounce
python3 example_02.py   # eventos y callback
python3 example_03.py   # pulsación corta/larga
```

Detén con `Ctrl+C`; el programa limpia los GPIO en la salida.

## Checklist rápido antes de probar

- ¿El LED enciende en la lección 00? (verifica cableado).
- `python3 -c "import RPi.GPIO as GPIO; print(GPIO.VERSION)"` funciona sin errores.
- El botón está entre GPIO17 y GND; sin conexión flotante.

## Qué puedes modificar

- Pines: cambia `GPIO17` y `GPIO18` en el código si usas otros.
- Antirrebote: ajusta el tiempo de debounce (ms) según el botón.
- Lógica: modifica qué hace la pulsación corta/larga.
- Pull-up/pull-down: cambia a `GPIO.PUD_DOWN` y re-cablea si lo necesitas.

## Errores comunes

- No usar pull-up/pull-down y dejar el pin flotante.
- Cablear el botón a 3.3V cuando el código espera GND (o viceversa).
- Usar `sleep` largos en el hilo principal y perder eventos.
- Confundir BCM con numeración física.

## Reto corto

- Agrega un segundo botón y controla una segunda acción.
- Cambia el umbral de pulsación larga y comprueba el efecto.

## Próximos pasos sugeridos

- Leer dos botones y controlar dos acciones diferentes.
- Reemplazar la espera activa (`time.sleep`) por un loop principal no bloqueante (ej. mezcla de eventos y temporizador).
- Integrar PWM para variar brillo en función de pulsaciones.
