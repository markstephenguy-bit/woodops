#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="${1:-/opt/woodops/repo}"
SRC_ROOT="${REPO_ROOT}/infra/docker"
TARGET_ROOT="${REPO_ROOT}/infra_v2/services"

echo "REPO_ROOT=${REPO_ROOT}"
echo "SRC_ROOT=${SRC_ROOT}"
echo "TARGET_ROOT=${TARGET_ROOT}"

copy_dir_contents() {
  local src="$1"
  local dst="$2"

  mkdir -p "${dst}"

  if [[ -d "${src}" ]]; then
    cp -a "${src}/." "${dst}/"
    echo "COPIED ${src} -> ${dst}"
  else
    echo "MISSING ${src}"
  fi
}

copy_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "${dst}")"

  if [[ -f "${src}" ]]; then
    cp -a "${src}" "${dst}"
    echo "COPIED ${src} -> ${dst}"
  else
    echo "MISSING ${src}"
  fi
}

copy_dir_contents \
  "${SRC_ROOT}/foundation/traefik/dynamic" \
  "${TARGET_ROOT}/traefik/dynamic"

copy_file \
  "${SRC_ROOT}/foundation/pgbouncer/pgbouncer.ini" \
  "${TARGET_ROOT}/pgbouncer/pgbouncer.ini"

copy_file \
  "${SRC_ROOT}/foundation/pgbouncer/userlist.txt" \
  "${TARGET_ROOT}/pgbouncer/userlist.txt"

copy_dir_contents \
  "${SRC_ROOT}/data/trino/catalog" \
  "${TARGET_ROOT}/trino/catalog"

echo
echo "Resulting copied files:"
find "${REPO_ROOT}/infra_v2/services" \
  \( -path "*/traefik/*" -o -path "*/pgbouncer/*" -o -path "*/trino/*" \) \
  -type f | sort
