# Getting the data

```sh
git clone https://github.com/nlumineau/ens-bd.git
```


# Testing locally

```
docker run --rm -it --name postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/data \
    -v $(pwd)/data/db-data:/db-data.sql \
    -v $(pwd)/init-db.sh:/docker-entrypoint-initdb.d/init-db.sh \
    postgres:17.5

```



# Building the GGMD INSEE image

```
docker build --no-cache -t bdens .

docker build -t ggmd-citus -f Dockerfile-citus .

```

# Send image to Docker Hub

```
docker tag ggmd jaeo/ggmd
docker tag ggmd-citus jaeo/ggmd:citus

docker push jaeo/ggmd
docker push jaeo/ggmd:citus
```


# Trying the image

```
docker run -d --name postgres ggmd      # docker run -d --name postgres jaeo/ggmd

# docker run -d --name postgres ggmd-citus 

docker exec -it postgres psql -U postgres 

docker exec -it postgres psql -U postgres -c "SELECT * FROM citus_version();"


\c insee
\dt

docker stop postgres && docker rm postgres

```