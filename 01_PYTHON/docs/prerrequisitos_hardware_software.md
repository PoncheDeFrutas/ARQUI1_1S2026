# Prerrequisitos de hardware y software (Python + GPIO en Raspberry Pi)

Guía rápida para preparar el entorno físico y de software antes de ejecutar las lecciones de Python con GPIO. Estas prácticas se realizarán **en Raspberry Pi real (sin QEMU)**.

## Hardware mínimo recomendado

- Raspberry Pi 3B/3B+, 4B o 5 (arquitectura ARM64).
- Fuente oficial o equivalente: 5V/3A (Pi 3) o 5V/3A–5A (Pi 4/5) con cable USB-C/Micro-USB adecuado.
- MicroSD 16GB o superior, clase 10, con Raspberry Pi OS de 64 bits.
- Red: Ethernet o Wi‑Fi configurado para tener acceso a paquetes y actualizaciones.
- Prototipado: protoboard pequeña, 10–20 jumpers macho‑macho, 4 LEDs, resistencias 220–330 Ω (una por LED) y 1 botón con resistencia 10 kΩ (o módulo de botón con pull-up integrado).
- Opcional cercano: pin header ya soldado (si usas Pi Zero) y disipador/ventilador si trabajas en cargas prolongadas.

## Software base (Raspberry Pi OS)

- Raspberry Pi OS **64 bits** actualizado.
- Python 3.9+ (viene preinstalado). Verifica con: `python3 --version`.
- Gestor de paquetes: `pip3` (preinstalado en Pi OS reciente). Verifica con: `pip3 --version`.
- Librería GPIO principal: `RPi.GPIO` (suele venir incluida). Si falta o quieres asegurar versión reciente:

```bash
sudo apt update && sudo apt install -y python3-rpi.gpio
```

- Herramientas de apoyo: `git`, `nano`/`vim`, y opcionalmente VS Code + extensión Remote SSH en tu PC para editar de forma remota.

## Configuración inicial rápida

1) Actualiza paquetes y firmware (opcional pero recomendado):

```bash
sudo apt update && sudo apt full-upgrade -y
sudo reboot
```

2) Habilita SSH si trabajarás en remoto:

```bash
sudo raspi-config   # Interface Options -> SSH -> Enable
```

3) Clona o sincroniza el repositorio en la Pi en un directorio de trabajo (ej. `~/ARQUI1_1S2026`).

## Checklist antes de correr las lecciones

- `python3 --version` y `pip3 --version` muestran versiones sin error.
- `python3 -c "import RPi.GPIO as GPIO; print(GPIO.VERSION)"` funciona sin excepciones.
- Usuario tiene permisos de GPIO (en Raspberry Pi OS estándar, el grupo `gpio` ya está configurado; si no, ejecuta con `sudo` o añade tu usuario: `sudo adduser $USER gpio`).
- Pines físicos están cableados según la numeración **BCM** usada en los ejemplos (LEDs: 18, 23, 24, 25 por defecto en `example_02.py`).
- Tienes resistencias en serie con cada LED (220–330 Ω) y un botón con pull-up/pull-down adecuado si lo usas.

## Qué NO usamos en este módulo

- No usamos QEMU ni emulación para las prácticas de GPIO.
- No usamos herramientas de cross-compiling; todo corre nativo en la Raspberry Pi.

## Troubleshooting rápido

- Error `RuntimeError: No access to /dev/mem` → ejecuta con `sudo` o añade tu usuario al grupo `gpio` y reinicia sesión.
- LED no enciende → revisa polaridad, resistencia en serie y que el pin esté configurado en modo BCM correcto.
- ImportError `No module named RPi` → reinstala con `sudo apt install python3-rpi.gpio`.

