#!/usr/bin/env bash
set -euo pipefail

cd /opt/woodops/repo

docker compose \
  --env-file /opt/woodops/repo/infra/env/.env.local \
  -f /opt/woodops/repo/infra/docker/base/docker-compose.base.yml \
  -f /opt/woodops/repo/infra/docker/bootstrap/docker-compose.bootstrap.yml \
  down

docker compose \
  --env-file /opt/woodops/repo/infra/env/.env.local \
  -f /opt/woodops/repo/infra/docker/base/docker-compose.base.yml \
  -f /opt/woodops/repo/infra/docker/bootstrap/docker-compose.bootstrap.yml \
  up -d
