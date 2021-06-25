.PHONY: all help create-env install-requirements alembic-init db-upgrade db-revision db-raw-query lint-flake lint-black security-check compile-requirements clean

PYTHON_VERSION := python3.8

all: help
help:
	# This is self documentation
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

create-env: ## Create virtual environment
	$(PYTHON_VERSION) -m pip install --upgrade virtualenv
	$(PYTHON_VERSION) -m virtualenv venv && venv/bin/activate

install-requirements: ## Install requirements
	$(PYTHON_VERSION) -m pip install -r requirements.in
	$(PYTHON_VERSION) -m pip install -r requirements.txt

alembic-init: ## Initiate database migrations
	@alembic init migrations

db-upgrade: ## Prepare for database migrations
	@alembic upgrade head

db-revision: MESSAGE ?= new migrations
db-revision: ## alembic revision
	@alembic revision --autogenerate -m "$(MESSAGE)"

db-raw-query: ## Get raw SQL query.
	@alembic upgrade head --sql > raw_query.sql

lint-flake: ## Perform code linting by flake8
	$(PYTHON_VERSION) -m flake8

lint-black: ## Preform code linting using black
	$(PYTHON_VERSION) -m black .

security-check: ## Security check
	$(PYTHON_VERSION) -m bandit -r .

compile-requirements: ## Perform pip-compile
	@pip-compile requirements.in

clean: ## Remove unwanted stuff
	@rm -fr venv

.DEFAULT_GOAL := help
