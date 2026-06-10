import csv
import os
import subprocess
from pathlib import Path

from dotenv import load_dotenv
from flask import Flask, jsonify, request
from pymongo import DESCENDING
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

app = Flask(__name__)

load_dotenv()

MONGODB_URI = os.getenv("MONGODB_URI")
MONGODB_DB = os.getenv("MONGODB_DB")
MONGODB_COLLECTION = os.getenv("MONGODB_COLLECTION")

CSV_PATH = Path("src/lecturas.csv")


def get_collection():
    client = MongoClient(MONGODB_URI, server_api=ServerApi("1"))
    return client[MONGODB_DB][MONGODB_COLLECTION]


def crear_csv():
    collection = get_collection()

    documentos = list(
        collection.find()
        .sort("_id", DESCENDING)
        .limit(30)
    )

    documentos.reverse()

    CSV_PATH.parent.mkdir(parents=True, exist_ok=True)

    with CSV_PATH.open("w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)

        writer.writerow([
            "ID",
            "TEMP",
            "HUM_AIRE",
            "HUM_SUELO_1",
            "HUM_SUELO_2",
            "LUZ",
            "GAS",
            "RIEGO_1",
            "RIEGO_2",
        ])

        for index, doc in enumerate(documentos, start=1):
            writer.writerow([
                index,
                int(doc.get("temperatura", 0)),
                int(doc.get("humedad", 0)),
                int(doc.get("hum_suelo_1", 0)),
                int(doc.get("hum_suelo_2", 0)),
                int(doc.get("luz", 0)),
                int(doc.get("gas_ppm", 0)),
                int(doc.get("riego_1", 0)),
                int(doc.get("riego_2", 0)),
            ])

        file.write("$\n")

    return len(documentos)


@app.route("/")
def home():
    return "Si estoy vivo"


@app.route("/api/analizar", methods=["POST"])
def analizar():
    try:
        columna = request.get_data(as_text=True).strip()

        if not columna.isdigit():
            return jsonify({
                "error": "Debe enviar solo el número de columna"
            }), 400

        total = crear_csv()

        result = subprocess.run(
            ["./build/main", columna],
            cwd="src",
            capture_output=True,
            text=True,
            timeout=10
        )

        return jsonify({
            "columna": int(columna),
            "documentos": total,
            "salida": result.stdout.strip(),
            "error": result.stderr.strip(),
            "codigo": result.returncode
        })

    except Exception as exc:
        return jsonify({
            "error": str(exc)
        }), 500


if __name__ == "__main__":
    app.run(debug=True, port=5000)
