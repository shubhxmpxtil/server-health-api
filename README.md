# server-health-api

Small Python API used to demonstrate a full DevOps pipeline:
Git → CI (GitHub Actions) → container → Kubernetes → GitOps → monitoring.

## Endpoints
- `/`        app info (version, host)
- `/health`  health check
- `/metrics` Prometheus metrics

## Run locally
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements-dev.txt
    python -m pytest
    python -m app.main
