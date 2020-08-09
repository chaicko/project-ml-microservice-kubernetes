import os
import tempfile

import pytest

import app

# read in SQL for populating test data
#with open(os.path.join(os.path.dirname(__file__), "data.sql"), "rb") as f:
#    _data_sql = f.read().decode("utf8")


@pytest.fixture
def api():
    """Create and configure a new app instance for each test."""
    # create a temporary file to isolate the database for each test
    # create the app with common test config
    api = app.app

    # create the database and load test data
    with api.app_context():
        pass

    yield api

    # close and remove the temporary database
    #os.close(db_fd)
    #os.unlink(db_path)


@pytest.fixture
def client(api):
    """A test client for the app."""
    return api.test_client()


@pytest.fixture
def runner(api):
    """A test runner for the app's Click commands."""
    return api.test_cli_runner()

