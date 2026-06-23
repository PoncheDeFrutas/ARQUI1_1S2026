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

try:
    while True:
        linea = ",".join(str(random.randint(0, 100)) for _ in range(2))

        print(f"Python envia: {linea}")

        proceso.stdin.write(linea + "\n")
        proceso.stdin.flush()

        respuesta = proceso.stdout.readline().strip()
        print(f"ARM64 responde: {respuesta}")
        time.sleep(1)
except KeyboardInterrupt:
    print("Interrupción del usuario. Cerrando el proceso...")
    # cerrar comunicacion al final
    proceso.stdin.close()
    proceso.wait()

