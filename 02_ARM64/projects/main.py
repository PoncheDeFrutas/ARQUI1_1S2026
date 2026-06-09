import subprocess

texto = "Hola mundo"

result = subprocess.run(
    ['../src/build/09_demo_param', texto],
    capture_output=True,
    text=True
)

print(result.returncode)
print(result.stdout)
print(result.stderr)
