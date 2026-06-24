import RPi.GPIO as GPIO
import subprocess
import time

AMR64_PROGRAM = "./build/motor"
INTERVALO = 2
LED_PIN = 18

LECTURAS_TEMP = [25, 27, 29, 31, 35, 36, 34, 28, 26, 24]


def preparar_gpio():
    try:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(LED_PIN, GPIO.OUT)
        GPIO.setwarnings(False)
    except Exception:
        print("Error al configurar GPIO. Asegúrate de tener permisos de superusuario.")

def applicar_accion(accion):
    if accion == "ACTION=LED_ON":
        print("Encendiendo LED...")
        GPIO.output(LED_PIN, GPIO.HIGH)
    elif accion == "ACTION=LED_OFF":
        print("Apagando LED...")
        GPIO.output(LED_PIN, GPIO.LOW)
    else:
        print(f"Acción desconocida: {accion}")

def main():
    preparar_gpio()

    proceso = subprocess.Popen(
        [AMR64_PROGRAM],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        bufsize=1
    )

    if proceso.stdin is None:
        raise RuntimeError("No se pudo abrir la entrada estándar del proceso.")

    if proceso.stdout is None:
        raise RuntimeError("No se pudo abrir la salida estándar del proceso.")

    try:
        for lectura in LECTURAS_TEMP:
            print(f"\n lecutra: {lectura}")

            proceso.stdin.write(f"{lectura}\n")
            proceso.stdin.flush()

            respuesta = proceso.stdout.readline().strip()

            print(f"Respuesta del ARM64: {respuesta}")

            applicar_accion(respuesta)

            time.sleep(INTERVALO)

    finally:
        print("Cerrando el proceso...")
        proceso.stdin.close()
        proceso.wait()
        GPIO.cleanup()

if __name__ == "__main__":
    main()
