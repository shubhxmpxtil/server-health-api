import os
import socket
import time

from flask import Flask, jsonify
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

START_TIME = time.time()
APP_VERSION = os.getenv("APP_VERSION", "dev")

REQUESTS = Counter("app_requests_total", "Total HTTP requests", ["endpoint"])


@app.route("/")
def index():
    REQUESTS.labels(endpoint="/").inc()
    return jsonify(
        app="server-health-api",
        version=APP_VERSION,
        host=socket.gethostname(),
    )


@app.route("/health")
def health():
    REQUESTS.labels(endpoint="/health").inc()
    return jsonify(status="ok", uptime_seconds=round(time.time() - START_TIME, 1))


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
