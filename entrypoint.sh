#!/bin/bash

# copy of https://github.com/gisgraphy/gisgraphy-docker/blob/master/base/assets/install-gisgraphy.sh

set -e

DB_PROPS="/usr/local/gisgraphy/webapps/ROOT/WEB-INF/classes/jdbc.properties"

envsubst '\$PG_USER \$PG_PASS \$PG_HOST \$GISGRAPHY_DB' < /usr/local/gisgraphy/jdbc.properties > $DB_PROPS

function does_db_exist() {
    psql -U $PG_USER -h $PG_HOST -lqt | cut -d \| -f 1 | grep -wq $1
}

function db_setup() {

    DB_NAME="gisgraphy"

    sleep 10 # wait for db to be up
    export PGPASSWORD=$PG_PASS

    if does_db_exist $DB_NAME
    then
        echo -e "$DB_NAME db exists, skipping create"
    else
        echo -e "$DB_NAME db does not exist, creating"
        psql -U $PG_USER -h $PG_HOST -c "CREATE DATABASE gisgraphy ENCODING = 'UTF8';"
        psql -U $PG_USER -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/create_tables.sql
        psql -U $PG_USER -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/insert_users.sql
        psql -U $PG_USER -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/createGISTIndex.sql
    fi
}

db_setup

exec "$@"