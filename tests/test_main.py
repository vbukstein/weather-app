import os
import pytest
from app.main import app

@pytest.fixture
def client():
    # Set up test client
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_homepage_get(client):
    """Test GET request to homepage."""
    response = client.get('/')
    assert response.status_code == 200
    assert b"City" in response.data  # Adjust according to your HTML

def test_health_endpoint(client):
    """Test /health endpoint."""
    response = client.get('/health')
    assert response.status_code == 200
    assert response.is_json
    assert response.get_json() == {"response": 200}
