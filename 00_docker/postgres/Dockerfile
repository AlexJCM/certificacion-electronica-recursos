FROM postgres:12.8-alpine

ENV POSTGRES_PASSWORD=DEFAULT_BONITA_ROOT_PSSWD

COPY ./scripts/0_init-databases.sql /docker-entrypoint-initdb.d/0_init-databases.sql
COPY ./scripts/1_set-optimized-config.sh /docker-entrypoint-initdb.d/1_set-optimized-config.sh
