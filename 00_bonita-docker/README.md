# Pre-configured Bonita 7.12 + Postgres databas

### Quick start

docker run --name dev-bonita -d -p 8080:8080 bonita:2021

docker run --name dev-bonita -v /opt/bonita:/opt/bonita -d -p 8080:8080 bonita:2021

This will start a container running Bonita runtime: a Tomcat bundle with Bonita Engine + Bonita Portal.


## Modify default credentials

docker run --name=bonita -e "TENANT_LOGIN=tech_user" -e "TENANT_PASSWORD=secret" -e "PLATFORM_LOGIN=pfadmin" -e "PLATFORM_PASSWORD=pfsecret" -d -p 8080:8080 dev-bonita


## Build and run it

## Execute shell command inside container

`docker exec -it dev-bonita bash`


## Build and run it with Docker Compose

Build images before starting containers:

```
docker-compose up --build -d
```

Create and start containers:

```
docker-compose up -d
```

Stop and remove containers, networks.
Remove named volumes declared in the volumes section of the Compose file and anonymous volumes attached to containers.
Remove containers for services not defined in the Compose file.

```
docker-compose down -v --remove-orphans
```

## Logs 

```
docker logs -f dev-bonita
```

