import os
from flask import Flask, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

FRONTEND_URL = os.getenv("FRONTEND_URL", "*")

CORS(app, resources={
    r"/*": {
        "origins": FRONTEND_URL
    }
})


@app.route("/")
def home():
    return "Si estoy vivo"


@app.route("/health")
def health():
    return jsonify({
        "status": "ok",
        "message": "Backend vivo",
        "service": "raspberry-backend"
    })


if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
