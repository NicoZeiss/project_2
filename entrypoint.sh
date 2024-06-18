#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z db_2 5434; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py collectstatic
gunicorn project_2.wsgi:application --bind 0.0.0.0:8002

exec "$@"