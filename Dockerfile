# Section 1- Base Image
FROM python:3.8-slim AS development_build

# Section 2- Python Interpreter Flags
ARG DJANGO_ENV
ENV DJANGO_ENV=${DJANGO_ENV} \
	# python:
	PYTHONFAULTHANDLER=1 \
	PYTHONUNBUFFERED=1 \
	PYTHONHASHSEED=random \
	# pip:
	PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PIP_DEFAULT_TIMEOUT=100 \
	# poetry:
	POETRY_VERSION=1.1.13 \
	POETRY_VIRTUALENVS_CREATE=false \
	POETRY_CACHE_DIR='/var/cache/pypoetry'

# Section 3- Compiler and OS libraries
RUN apt-get update \
	&& apt-get install --no-install-recommends -y \
    bash \
    build-essential \
    curl \
    gettext \
    git \
    libpq-dev \
    wget \
	# Cleaning cache:
	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
	&& pip install "poetry==$POETRY_VERSION" && poetry --version

# set work directory
WORKDIR /code
COPY pyproject.toml poetry.lock /code/

# Install dependencies:
RUN poetry install
# copy project
COPY . .
