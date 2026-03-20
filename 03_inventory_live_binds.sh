 #!/usr/bin/env bash
set -Eeuo pipefail

OUTPUT_PATH="${1:-/opt/woodops/repo/infra_v2/snapshots/live_bind_inventory.tsv}"

mkdir -p "$(dirname "${OUTPUT_PATH}")"

CONTAINERS=(
  woodops_postgres
  woodops_redis
  woodops_minio
  woodops_mongodb
  woodops_clickhouse
  woodops_opensearch
  woodops_opensearch_dashboards
  woodops_traefik
  woodops_keycloak
  woodops_vault
  woodops_pgbouncer
  woodops_pgadmin
  woodops_nifi
  woodops_tika
  woodops_ocr
  woodops_iceberg_rest
  woodops_trino
)

{
  printf "service\tcontainer\ttype\tsource\tdestination\trw\n"

  for container in "${CONTAINERS[@]}"; do
    if ! docker inspect "${container}" >/dev/null 2>&1; then
      printf "UNKNOWN\t%s\tMISSING\t\t\t\n" "${container}"
      continue
    fi

    docker inspect "${container}" \
      --format '{{range .Mounts}}{{$.Name}}|{{$.Config.Image}}|{{.Type}}|{{.Source}}|{{.Destination}}|{{.RW}}{{println}}{{end}}' |
    while IFS='|' read -r volume_name image type source destination rw; do
      service="${container#woodops_}"
      printf "%s\t%s\t%s\t%s\t%s\t%s\n" \
        "${service}" \
        "${container}" \
        "${type}" \
        "${source}" \
        "${destination}" \
        "${rw}"
    done
  done
} > "${OUTPUT_PATH}"

echo "Wrote ${OUTPUT_PATH}"
column -t -s $'\t' "${OUTPUT_PATH}" || cat "${OUTPUT_PATH}"
