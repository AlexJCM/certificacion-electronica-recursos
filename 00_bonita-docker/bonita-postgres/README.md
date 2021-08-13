# Pre-configured Postgres database image to work with Bonita 7.12

This image is based on the [official Postgres image](https://hub.docker.com/_/postgres)

### Configuration

Set required `max_prepared_transactions` setting required by Bonita.

### Databases

When starting a new container, it will create two databases...
* `bonita` (connection user `bonita`, password `bpm`)
* `business_data` (connection user `business_data`, password `bpm`)


## Build and run it

`docker build -t my-bonita-postgres .`

Recommended way, to have datafiles out of container: bind a volume to **/var/lib/postgresql/data**

```
docker run -d \
    --name dev-postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v ${HOME}/postgres-data/:/var/lib/postgresql/data \
    -p 5432:5432 \
    my-bonita-postgres
```

## Execute shell command inside container

`docker exec -it dev-postgres bash`

Verify that the user and database have been created correctly:

```
psql -d bonita_db -h 127.0.0.1 -U bonita_db_user
-- Expected return: 1
SELECT 1; \q
```

## Build and run it with Docker Compose

```
docker-compose up --build -d
 
docker-compose down -v --remove-orphans

```


## Review configurations (optional)

cat /var/lib/postgresql/data/pgdata/postgresql.conf
cat /var/lib/postgresql/data/pgdata/pg_hba.conf


