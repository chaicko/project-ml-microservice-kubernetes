import pytest

def test_index(client):
    response = client.get("/")
    assert b"<h3>Sklearn Prediction Home</h3>" in response.data
