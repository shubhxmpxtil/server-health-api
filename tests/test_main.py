from app.main import app


def test_index_returns_app_name():
    client = app.test_client()
    resp = client.get("/")
    assert resp.status_code == 200
    assert resp.get_json()["app"] == "server-health-api"


def test_health_is_ok():
    client = app.test_client()
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.get_json()["status"] == "ok"


def test_metrics_endpoint():
    client = app.test_client()
    resp = client.get("/metrics")
    assert resp.status_code == 200
    assert b"app_requests_total" in resp.data


def test_version():
    client = app.test_client()
    resp = client.get("/version")
    assert resp.status_code == 200
    assert "version" in resp.get_json()
