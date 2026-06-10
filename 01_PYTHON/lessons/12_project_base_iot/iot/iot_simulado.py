import os
import random
import time
from datetime import datetime, timezone

from dotenv import load_dotenv
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi


def get_collection():
    load_dotenv()

    uri = os.getenv("MONGODB_URI")
    db_name = os.getenv("MONGODB_DB")
    col_name = os.getenv("MONGODB_COLLECTION")

    if not uri:
        raise RuntimeError("Falta MONGODB_URI en .env")

    if not db_name:
        raise RuntimeError("Falta MONGODB_DB en .env")

    if not col_name:
        raise RuntimeError("Falta MONGODB_COLLECTION en .env")

    client = MongoClient(uri, server_api=ServerApi("1"))
    return client[db_name][col_name]


def generar_lectura():
    temp = random.randint(24, 34)
    hum_aire = random.randint(50, 80)
    hum_suelo_1 = random.randint(30, 60)
    hum_suelo_2 = random.randint(30, 60)
    luz = random.randint(250, 700)
    gas = random.randint(90, 180)

    riego_1 = 1 if hum_suelo_1 < 40 else 0
    riego_2 = 1 if hum_suelo_2 < 40 else 0

    return {
        "sensor": "raspi-01",
        "temperatura": temp,
        "humedad": hum_aire,
        "hum_suelo_1": hum_suelo_1,
        "hum_suelo_2": hum_suelo_2,
        "luz": luz,
        "gas_ppm": gas,
        "riego_1": riego_1,
        "riego_2": riego_2,
        "created_at": datetime.now(timezone.utc),
    }


def main():
    collection = get_collection()

    print("Simulador IoT iniciado.")

    try:
        while True:
            lectura = generar_lectura()
            result = collection.insert_one(lectura)

            print(f"Insertado _id={result.inserted_id}")
            print(lectura)
            print("-" * 60)

            time.sleep(1)

    except KeyboardInterrupt:
        print("\nSimulador detenido.")

if __name__ == "__main__":
    main()
