FROM apache/superset:6.0.0rc1-py311

LABEL org.opencontainers.image.source=https://github.com/martyngigg/analytics-data-platform__container_images
LABEL org.opencontainers.image.description="Custom build of Apache Superset"
LABEL org.opencontainers.image.licenses=MIT

USER root

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

RUN /app/docker/pip-install.sh --requires-build-essential \
    # PostgreSQL metadata store
    psycopg2-binary==2.9.10 \
    # Authenication with LDAP/AD
    python-ldap==3.4.4 \
    # Trino for Iceberg catalo access
    trino[sqlalchemy]==0.336.0 \
    # Pillow for Alerts & Reports to generate PDFs of dashboards
    Pillow==11.3.0 \
    # For trend prediction on charts
    prophet==1.1.5 \
    # Redis for caching results
    redis==6.4.0 \
    # install Playwright for taking screenshots for Alerts & Reports.
    # This assumes the feature flag PLAYWRIGHT_REPORTS_AND_THUMBNAILS is enabled
    # That feature flag will default to True starting in 6.0.0
    # Playwright works only with Chrome.
    playwright \
    && playwright install-deps \
    && PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers playwright install chromium

# Switch back to the superset user
USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
