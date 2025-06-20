FROM quay.io/astronomer/astro-runtime:13.0.0

USER root
RUN apt-get update && apt-get install -y \
    gcc \
    g++

USER astro
RUN python -m venv soda_venv && source soda_venv/bin/activate && \
pip install --no-cache-dir soda-core-bigquery==3.0.45 &&\
pip install --no-cache-dir soda-core-scientific==3.0.45 && deactivate

RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
     pip install --no-cache-dir setuptools && \
     pip install --no-cache-dir dbt-bigquery==1.5.3 && deactivate

COPY requirements.txt .
COPY constraints.txt .

RUN pip install --no-cache-dir -r requirements.txt -c constraints.txt