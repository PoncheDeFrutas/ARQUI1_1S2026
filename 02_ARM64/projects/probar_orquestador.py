import subprocess
import time
import random

proceso = subprocess.Popen(
    ["../projects/src/build/14_motor"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
    bufsize=1
)


datos = []
for _ in range(100):
    a = random.randint(1, 100)
    b = random.randint(1, 100)
    datos.append(f"{a},{b}")


for linea in datos:
    print(f"Python envia: {linea}")

    proceso.stdin.write(linea + "\n")
    proceso.stdin.flush()

    respuesta = proceso.stdout.readline().strip()
    print(f"ARM64 responde: {respuesta}")
    time.sleep(1)

# cerrar comunicacion al final
proceso.stdin.close()
proceso.wait()
