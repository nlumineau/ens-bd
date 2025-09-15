#!/usr/bin/env bash
set -e

TP_DB="cinema"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create database "$TP_DB";
    create user etu with password 'pwdetu';
    GRANT ALL PRIVILEGES ON DATABASE "$TP_DB" to etu;
EOSQL


psql -v ON_ERROR_STOP=0 -d "$TP_DB" -a -U etu -f /home/ubuntu/ens-db/data/db-data.sql