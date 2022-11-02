# Gisgraphy Docker

Gisgraphy standalone in a Docker Container

## Setup PostgreSQL

The following docs outline how your PostgreSQL instance should be configured

- https://www.gisgraphy.com/documentation/installation/setuplinux.php#steps

Note changes required in `pg_hba.conf`

Please see `entrypoint.sh` for SQL executed on first run, as per install doc

## Build the Image
```
docker build -t gisgraphy-image .
```

## Running the Container
```
# update the PG_* variables with those of your instance

docker run -it -d --name gisgraphy -p 8080:8080 -e "GISGRAPHY_DB=gisgraphy" \
        -e "PG_HOST=database" -e "PG_USER=mdppostgres" -e "PG_PASS=pgsecurepass" gisgraphy-image

# docker compose (to run with an instance of PostgreSQL)

docker compose up -d --build
```

Following

- https://www.gisgraphy.com/documentation/installation/installgisgraphy.php