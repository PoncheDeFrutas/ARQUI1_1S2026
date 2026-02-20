# Lección 03: Tareas periódicas y temporizadores (Raspberry Pi)

Aprende a ejecutar tareas en paralelo sin bloquear el bucle principal: heartbeat LED en segundo plano, lectura periódica de sensor y callbacks de botón al mismo tiempo.

## Objetivos

- Diferenciar espera bloqueante (`sleep`) de tareas periódicas con hilos.
- Usar `threading.Thread` y `threading.Event` para bucles con parada limpia.
- Re-armar `threading.Timer` para acciones puntuales sin bloquear.
- Seguir manejando interrupciones físicas con `add_event_detect`.

## Requisitos

- Hardware previo: LED en GPIO18, botón en GPIO17 (pull-up). Opcional: sensor simulado (se usan lecturas aleatorias en ejemplos).
- Software: `RPi.GPIO`, Python 3.9+.

## Archivos de la lección

- `heartbeat_thread.py`: hilo en segundo plano que parpadea un LED mientras el hilo principal permanece libre.
- `sensor_and_button.py`: hilo periódico de “sensor” (simulado) + callback de botón que conmuta LED sin bloquear.
- `timer_rearm.py`: uso de `threading.Timer` rearmable para ejecutar una tarea puntual cada cierto tiempo.

## Cómo ejecutar

Desde esta carpeta:

```bash
python3 heartbeat_thread.py
python3 sensor_and_button.py
python3 timer_rearm.py
```

Detén con `Ctrl+C`; los ejemplos limpian GPIO y detienen hilos/timers de forma segura.

## Notas rápidas

- Usa `threading.Event` para indicar a los hilos que deben detenerse.
- No mezcles `time.sleep` largos en el hilo principal si dependes de callbacks; evita bloquear.
- Si añades sensores reales, coloca los accesos a GPIO dentro del hilo del sensor o protege con locks si hay escritura compartida.

## Qué puedes modificar

- Periodos: cambia el intervalo del heartbeat y del “sensor”.
- Tareas: reemplaza la lectura simulada por un sensor real.
- Parada limpia: ajusta cómo y cuándo se activa el `Event`.
- Acciones del botón: cambia la lógica del callback.

## Errores comunes

- Crear timers nuevos sin cancelarlos (se acumulan).
- Hacer trabajo pesado dentro del callback de evento.
- Olvidar detener hilos al salir (pueden quedar en segundo plano).
- Acceder a GPIO desde múltiples hilos sin coordinación.

## Reto corto

- Agrega una segunda tarea periódica que escriba un log cada 2 segundos.
- Cambia el heartbeat para que haga un patrón doble (dos pulsos rápidos).

## Próximos pasos sugeridos

- Integrar PWM (Lección 02) dentro de un hilo de “actuador”.
- Añadir MQTT/HTTP (futura lección) en otro hilo o usando timers para publicar datos sin bloquear la respuesta a botones.
