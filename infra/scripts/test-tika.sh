#!/usr/bin/env bash
set -euo pipefail

tmp_file="/tmp/woodops-tika-test.txt"

cat <<'EOT' > "$tmp_file"
WoodOps bootstrap validation.
Tika should extract this text.
EOT

echo "== Plain text extraction =="
curl -fsS \
  -H 'Accept: text/plain' \
  -T "$tmp_file" \
  http://localhost:9998/tika
echo
echo

echo "== XML extraction =="
curl -fsS \
  -H 'Accept: text/xml' \
  -T "$tmp_file" \
  http://localhost:9998/tika
echo
echo

echo "== Metadata JSON =="
curl -fsS \
  -H 'Accept: application/json' \
  -T "$tmp_file" \
  http://localhost:9998/rmeta
echo
