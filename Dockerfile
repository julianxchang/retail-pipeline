FROM quay.io/astronomer/astro-runtime:13.0.0

# Install system dependencies (for compiling pandas and other packages)
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    python3-dev \
    libffi-dev \
    libpq-dev \
    libssl-dev \
    curl \
    git

# Install Soda in a virtual environment
USER astro
RUN python -m venv /usr/local/airflow/soda_venv && \
    /usr/local/airflow/soda_venv/bin/pip install --no-cache-dir soda-core-bigquery==3.0.45 && \
    /usr/local/airflow/soda_venv/bin/pip install --no-cache-dir soda-core-scientific==3.0.45