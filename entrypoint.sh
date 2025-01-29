#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

export PGPASSWORD="crypto_rails_pass"
until psql -h "db" -U "crypto_rails" -d "crypto_rails_development" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing commands"

# Создание и миграция базы данных
bundle exec rails db:create 2>/dev/null || true
bundle exec rails db:migrate
bundle exec rails db:seed

exec "$@"
