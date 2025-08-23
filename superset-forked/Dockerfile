FROM local/superset-build:latest

LABEL org.opencontainers.image.source=https://github.com/martyngigg/analytics-data-platform__container_images
LABEL org.opencontainers.image.description="Custom build of forked Apache Superset supporting non-root application path"
LABEL org.opencontainers.image.licenses=MIT

# Install Python requirements
USER root
RUN /app/docker/pip-install.sh --requires-build-essential \
  openpyxl==3.1.5 \
  psycopg2-binary==2.9.10 \
  prophet==1.1.5 \
  python-ldap==3.4.4 \
  trino[sqlalchemy]==0.332.0

# Run as superset
USER superset
