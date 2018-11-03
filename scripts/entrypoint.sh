#!/bin/bash

export PYTHONPATH=$AIRFLOW_HOME/dags:$PYTHONPATH

AIRFLOW_HOME="/usr/local/airflow"
CMD="airflow"
TRY_LOOP="10"
POSTGRES_HOST="db"
POSTGRES_PORT="5432"

# wait for DB
i=0
while ! python3 "$AIRFLOW_HOME"/check_postgres.py; do
i=$((i+1))
if [ $i -ge $TRY_LOOP ]; then
  echo "$(date) - ${POSTGRES_HOST}:${POSTGRES_PORT} still not reachable, giving up"
  exit 1
fi
echo "$(date) - waiting for ${POSTGRES_HOST}:${POSTGRES_PORT}... $i/$TRY_LOOP"
sleep 10
done

# initialize the DB for Airflow run. Remove this if you want metadata to persist
if [ "$1" = "webserver" ]; then
echo "Initialize database..."
$CMD initdb
fi

exec $CMD "$@"
