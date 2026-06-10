import csv
import os
from pathlib import Path

from dotenv import load_dotenv
from flask import Flask, jsonify, send_file
from pymongo import DESCENDING
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

app = Flask(__name__)

load_dotenv()

MONGODB_URI = os.getenv("MONGODB_URI")
MONGODB_DB = os.getenv("MONGODB_DB")
MONGODB_COLLECTION = os.getenv("MONGODB_COLLECTION")

CSV_PATH = Path("lecturas.csv")


def get_collection():
    if not MONGODB_URI:
        raise RuntimeError("Falta MONGODB_URI en .env")

    if not MONGODB_DB:
        raise RuntimeError("Falta MONGODB_DB en .env")

    if not MONGODB_COLLECTION:
        raise RuntimeError("Falta MONGODB_COLLECTION en .env")

    client = MongoClient(MONGODB_URI, server_api=ServerApi("1"))
    return client[MONGODB_DB][MONGODB_COLLECTION]


def normalizar_documento(doc, index):
    return {
        "ID": index,
        "TEMP": int(doc.get("temperatura", 0)),
        "HUM_AIRE": int(doc.get("humedad", 0)),
        "HUM_SUELO_1": int(doc.get("hum_suelo_1", 0)),
        "HUM_SUELO_2": int(doc.get("hum_suelo_2", 0)),
        "LUZ": int(doc.get("luz", 0)),
        "GAS": int(doc.get("gas_ppm", 0)),
        "RIEGO_1": int(doc.get("riego_1", 0)),
        "RIEGO_2": int(doc.get("riego_2", 0)),
    }


def crear_csv_ultimos_30():
    collection = get_collection()

    documentos = list(
        collection.find()
        .sort("_id", DESCENDING)
        .limit(30)
    )

    documentos.reverse()

    columnas = [
        "ID",
        "TEMP",
        "HUM_AIRE",
        "HUM_SUELO_1",
        "HUM_SUELO_2",
        "LUZ",
        "GAS",
        "RIEGO_1",
        "RIEGO_2",
    ]

    with CSV_PATH.open("w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=columnas)
        writer.writeheader()

        for index, doc in enumerate(documentos, start=1):
            writer.writerow(normalizar_documento(doc, index))

        file.write("$\n")

    return CSV_PATH, len(documentos)


@app.route("/")
def home():
    return "Si estoy vivo"


@app.route("/api/generar-csv", methods=["GET"])
def generar_csv():
    try:
        path, total = crear_csv_ultimos_30()

        return jsonify({
            "mensaje": "CSV generado correctamente",
            "archivo": str(path),
            "total_documentos": total
        })

    except Exception as exc:
        return jsonify({
            "mensaje": "Error al generar CSV",
            "error": str(exc)
        }), 500

def analizar_csv():


if __name__ == "__main__":
    app.run(debug=True, port=5000)
