## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

VENV ?= .venv
export VIRTUAL_ENV := $(abspath ${VENV})
PYTHON ?= $(VIRTUAL_ENV)/bin/python
PIP ?= $(VIRTUAL_ENV)/bin/pip
PYVER ?= python3
HADOLINT ?= $(VIRTUAL_ENV)/bin/hadolint
ifeq ($(shell uname),Darwin)
	HADOLINT_URL := "https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Darwin-x86_64"
else
	HADOLINT_URL := "https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64"
endif

$(VIRTUAL_ENV):
	@$(PYVER) -m venv $(VIRTUAL_ENV)
	@echo "activate your virtualenv with:"
	@echo "source $(VIRTUAL_ENV)/bin/activate"

$(PYTHON): requirements.txt dev-requirements.txt | $(VIRTUAL_ENV)
	@$(PIP) install --upgrade pip &&\
	 $(PIP) install -r requirements.txt -r dev-requirements.txt

$(HADOLINT): | $(VIRTUAL_ENV)
	wget -O $(HADOLINT) $(HADOLINT_URL) &&\
		chmod +x $(HADOLINT)

install: $(PYTHON) $(HADOLINT)

test: app.py $(wildcard tests/*.py)
	$(PYTHON) -m pytest -vv --cov=app tests

lint: Dockerfile app.py
	$(HADOLINT) Dockerfile
	$(PYTHON) -m pylint --disable=R,C,W1203 app.py

all: install lint test
