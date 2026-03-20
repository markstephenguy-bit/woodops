#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="${1:-/opt/woodops/repo}"
TARGET_ROOT="${REPO_ROOT}/infra_v2/volumes"

echo "REPO_ROOT=${REPO_ROOT}"
echo "TARGET_ROOT=${TARGET_ROOT}"

DIRS=(
  postgres/data
  redis/data
  minio/data
  mongodb/data
  mongodb/configdb
  clickhouse/data
  clickhouse/logs
  opensearch/data
  traefik/acme
  keycloak/data
  vault/file
  vault/logs
  pgadmin/data
  nifi/content_repository
  nifi/database_repository
  nifi/flowfile_repository
  nifi/provenance_repository
  nifi/state
  nifi/logs
  nifi/conf
  nifi/nar_extensions
  nifi/python_extensions
  ocr/work
  trino/data
)

for rel in "${DIRS[@]}"; do
  mkdir -p "${TARGET_ROOT}/${rel}"
  echo "CREATED ${TARGET_ROOT}/${rel}"
done

touch "${TARGET_ROOT}/traefik/acme/acme.json"
chmod 600 "${TARGET_ROOT}/traefik/acme/acme.json"

cat > "${TARGET_ROOT}/README.md" <<'EOF'
# infra_v2 volume roots

Purpose:
- define future portable host-managed state locations
- do not move live data here yet
- do not repoint running containers yet

Rule:
- these paths are placeholders until dry-run compose is ready
- current live state remains under existing /srv/woodops-data bindings during initial conversion
EOF

echo "Prepared volume roots under ${TARGET_ROOT}"
find "${TARGET_ROOT}" -maxdepth 3 | sort
