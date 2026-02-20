# Lección 02: PWM y control analógico simulado (Raspberry Pi)

Aprenderás a generar PWM con `RPi.GPIO` para controlar brillo de LEDs, un buzzer y un servo de 180°.

## Objetivos

- Entender frecuencia y duty cycle en PWM.
- Ajustar brillo de un LED y tono de un buzzer con PWM.
- Mover un servo estándar (SG90 o similar) usando PWM a 50 Hz.
- Aplicar rampas suaves (fade) y respetar límites eléctricos.

## Requisitos

- Raspberry Pi con RPi.GPIO operativo (ver `docs/prerrequisitos_hardware_software.md`).
- Hardware: 1 LED + resistencia 220–330 Ω, 1 buzzer activo o pasivo (5V/3.3V según modelo), 1 servo 180° (ej. SG90), protoboard y jumpers.

## Pines (modo BCM)

- LED PWM: GPIO 18 (pin 12) — canal hardware PWM disponible; para LED basta PWM por software.
- Buzzer: GPIO 23 (pin 16).
- Servo: GPIO 12 (pin 32) o GPIO 18; aquí usaremos GPIO 12.

## Archivos de la lección

- `pwm_led_fade.py`: rampa de brillo con PWM a 1000 Hz.
- `buzzer_tones.py`: tonos simples cambiando frecuencia.
- `servo_sweep.py`: barrido de servo con pulsos de 50 Hz.

## Cómo ejecutar

Desde esta carpeta:

```bash
python3 pwm_led_fade.py
python3 buzzer_tones.py
python3 servo_sweep.py
```

Detén con `Ctrl+C`; todos limpian GPIO en la salida.

## Notas rápidas

- PWM de LED: usa frecuencias altas (≥500 Hz) para evitar parpadeo visible.
- Buzzer pasivo: cambia frecuencia para generar tonos; si es activo, frecuencia fija y sólo controla encendido.
- Servo: rango típico 0.5–2.5 ms de pulso a 50 Hz (duty aprox. 2.5–12.5%); no exceder para evitar zumbido o daño.

## Próximos pasos sugeridos

- Combinar botón (Lección 01) para cambiar brillo/tono/posición.
- Implementar un “heartbeat LED” que indique vida del sistema mientras otras tareas corren.
