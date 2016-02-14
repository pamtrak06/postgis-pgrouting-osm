# What is postgis-pgrouting-osm ?

This container is build upon those images :
- [starefossen/pgrouting:9.4-2.1-2.1] (https://github.com/Starefossen/docker-pgrouting)
- [mdillon/postgis:9.4] (https://github.com/appropriate/docker-postgis)
- [postgres:9.4] (https://github.com/docker-library/postgres)
- [debian:jessie] (https://github.com/tianon/docker-brew-debian/blob/0a2d20ca8e26f7bf6a5cc3ce2727eb6cc1894ef9/jessie/Dockerfile)

Those osm tools are value added in this container :
- osm2pgrouting
> [Source : osm2pgrouting ](https://github.com/pgRouting/osm2pgrouting)
- osm2pgsql
> [Source : osm2pgsql ](https://github.com/openstreetmap/osm2pgsql)

# How to use this image

## Build a local image

This image is built upon postgis/pgrouting/ubuntu 14.04 with last osm tools (osm2pgrouting, osm2pgsql).
```
$ git clone https://github.com/pamtrak06/postgis-pgrouting-osm.git
$ cd postgis-pgrouting-osm
$ docker build -t pamtrak06/postgis-pgrouting-osm . 
```

## Run container

```
$ docker run -d -t -p 5432:5432 -v ./data:/data --name postgis-osm-pgrouting -e POSTGRES_PASSWORD=postgres pamtrak06/postgis-pgrouting-osm bash
```

Data are shared between host (./data) and container (/data).

Open a terminal session on a running container
```
$ docker exec -it $(docker ps | grep "pamtrak06/postgis-pgrouting-osm" | cut -d ' ' -f1) /bin/bash
```

Exit container without stop it
```
CTRL+P  &  CTRL+Q
```

Get docker vm ip frm windows or mac : 
```
$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.101:2376"
export DOCKER_CERT_PATH="/Users/jp/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell: 
# eval "$(docker-machine env default)"
```
