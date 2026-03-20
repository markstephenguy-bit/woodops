#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="${1:-/opt/woodops/repo}"
TARGET_ROOT="${REPO_ROOT}/infra_v2"

echo "REPO_ROOT=${REPO_ROOT}"
echo "TARGET_ROOT=${TARGET_ROOT}"

mkdir -p \
  "${TARGET_ROOT}/compose/base" \
  "${TARGET_ROOT}/compose/services" \
  "${TARGET_ROOT}/env" \
  "${TARGET_ROOT}/scripts" \
  "${TARGET_ROOT}/snapshots" \
  "${TARGET_ROOT}/services/postgres" \
  "${TARGET_ROOT}/services/redis" \
  "${TARGET_ROOT}/services/minio" \
  "${TARGET_ROOT}/services/mongodb" \
  "${TARGET_ROOT}/services/clickhouse" \
  "${TARGET_ROOT}/services/opensearch" \
  "${TARGET_ROOT}/services/opensearch-dashboards" \
  "${TARGET_ROOT}/services/traefik/dynamic" \
  "${TARGET_ROOT}/services/keycloak" \
  "${TARGET_ROOT}/services/vault/config" \
  "${TARGET_ROOT}/services/pgbouncer" \
  "${TARGET_ROOT}/services/pgadmin" \
  "${TARGET_ROOT}/services/nifi/conf" \
  "${TARGET_ROOT}/services/tika" \
  "${TARGET_ROOT}/services/ocr" \
  "${TARGET_ROOT}/services/iceberg-rest" \
  "${TARGET_ROOT}/services/trino/catalog" \
  "${TARGET_ROOT}/services/trino/etc" \
  "${TARGET_ROOT}/volumes/postgres/data" \
  "${TARGET_ROOT}/volumes/redis/data" \
  "${TARGET_ROOT}/volumes/minio/data" \
  "${TARGET_ROOT}/volumes/mongodb/data" \
  "${TARGET_ROOT}/volumes/mongodb/configdb" \
  "${TARGET_ROOT}/volumes/clickhouse/data" \
  "${TARGET_ROOT}/volumes/clickhouse/logs" \
  "${TARGET_ROOT}/volumes/opensearch/data" \
  "${TARGET_ROOT}/volumes/traefik/acme" \
  "${TARGET_ROOT}/volumes/keycloak/data" \
  "${TARGET_ROOT}/volumes/vault/file" \
  "${TARGET_ROOT}/volumes/vault/logs" \
  "${TARGET_ROOT}/volumes/pgadmin/data" \
  "${TARGET_ROOT}/volumes/nifi/content_repository" \
  "${TARGET_ROOT}/volumes/nifi/database_repository" \
  "${TARGET_ROOT}/volumes/nifi/flowfile_repository" \
  "${TARGET_ROOT}/volumes/nifi/provenance_repository" \
  "${TARGET_ROOT}/volumes/nifi/state" \
  "${TARGET_ROOT}/volumes/nifi/logs" \
  "${TARGET_ROOT}/volumes/nifi/conf" \
  "${TARGET_ROOT}/volumes/nifi/nar_extensions" \
  "${TARGET_ROOT}/volumes/nifi/python_extensions" \
  "${TARGET_ROOT}/volumes/ocr/work" \
  "${TARGET_ROOT}/volumes/trino/data"

touch "${TARGET_ROOT}/volumes/traefik/acme/acme.json"
chmod 600 "${TARGET_ROOT}/volumes/traefik/acme/acme.json"

cat > "${TARGET_ROOT}/env/.env.infra_v2.example" <<'EOF'
# infra_v2 environment placeholder
# Copy to .env.infra_v2.local and fill values later.

COMPOSE_PROJECT_NAME=woodops_v2
WOODOPS_NETWORK=woodops_v2_net
EOF

echo "Created infra_v2 tree at ${TARGET_ROOT}"
find "${TARGET_ROOT}" -maxdepth 3 | sort
