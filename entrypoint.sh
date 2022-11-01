#!/bin/bash

set -e

psql -Upostgres -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/create_tables.sql
psql -Upostgres -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/insert_users.sql
psql -Upostgres -h $PG_HOST -d gisgraphy -f /usr/local/gisgraphy/sql/createGISTIndex.sql
